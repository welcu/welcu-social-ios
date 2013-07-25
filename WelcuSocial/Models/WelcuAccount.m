//
//  WelcuAccount.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuAccount.h"

#import <FXKeychain/FXKeychain.h>

#import "WelcuSocialIncrementalStore.h"
#import "WelcuAppDelegate.h"

#define DEFAULT_PICTURE_SIZE 52

static WelcuAccount *currentAccount = nil;

@interface WelcuAccount ()

@property (strong) NSString *accessToken;
@property (strong) WelcuSocialClient *client;
@property (strong, nonatomic) NSDictionary *attributes;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) WelcuSocialIncrementalStore *incrementalStore;

#pragma mark Account Management

+ (void)setCurrentAccount:(WelcuAccount *)account;
+ (WelcuAccount *)loadAccount;
- (void)saveAccount;

- (id)initWithAccessToken:(NSString *)accessToken;
- (id)initWithAttributes:(NSDictionary *)attributes;
+ (void)authenticateWithWelcuAccessTokenData:(id)accessTokenData
                           complationHandler:(WelcuAccountAuthenticationCompletionHandler)handler;

@end

@implementation WelcuAccount

- (id)init
{
    return [self initWithAccessToken:nil];
}

- (id)initWithAccessToken:(NSString *)accessToken
{
    self = [super init];
    if (self) {
        self.accessToken = accessToken;
        self.client = [[WelcuSocialClient alloc] initWithAccount:self];
    }
    return self;
}

#pragma mark Account Management

+ (WelcuAccount *)currentAccount
{
    // Account already loaded
    if (currentAccount) {
        return currentAccount;
    }
    
    // Load persisted account data
    WelcuAccount *account = [self loadAccount];
    if (account) {
        [self setCurrentAccount:account];
        return currentAccount;
    }
    
    // User isn't logged in
    return nil;
}

+ (void)setCurrentAccount:(WelcuAccount *)account
{
    if (currentAccount == account) return;

    FXKeychain *keychain = [FXKeychain defaultKeychain];
    
    @synchronized(self) {
        
        currentAccount = account;

        if (account) {
            keychain[@"access_token"] = account.accessToken;
            keychain[@"user"] = account.attributes;
            
        } else {
            // Loging out
            keychain[@"access_token"] = nil;
            keychain[@"user"] = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"WelcuAccountLoggedOut" object:nil];
        }
        
    }
}

+ (void)logOut
{
    [self setCurrentAccount:nil];
}

- (NSDictionary *)attributes
{
    return @{
             @"id" : self.userID,
             @"first_name" : self.firstName,
             @"last_name" : self.lastName,
             @"facebook_uid" : self.facebookUID
             };
}

- (void)setAttributes:(NSDictionary *)attributes
{
    // TODO
    self.userID = attributes[@"id"];
    self.firstName = attributes[@"first_name"];
    self.lastName = attributes[@"last_name"];
    self.facebookUID = attributes[@"facebook_uid"];
}

+ (WelcuAccount *)loadAccount
{
    FXKeychain *keychain = [FXKeychain defaultKeychain];
    
    if (keychain[@"access_token"]) {
        WelcuAccount *account = [[WelcuAccount alloc] initWithAccessToken:keychain[@"access_token"]];
        [account setAttributes:keychain[@"user"]];
        
        return account;
    }
    
    return nil;
}

- (void)saveAccount
{
    // TODO
}



- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [self init];
    if (self) {
        self.userID = attributes[@"id"];
        self.firstName = attributes[@"first_name"];
        self.lastName = attributes[@"last_name"];
        self.facebookUID = attributes[@"facebook_uid"];
    }
    return self;
}

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}


- (NSURL *)pictureURL
{
    return [self pictureURLWithSize:DEFAULT_PICTURE_SIZE];
}

- (NSURL *)pictureURLWithSize:(NSInteger)pixels
{
    
    pixels = pixels * [[UIScreen mainScreen] scale];
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?height=%d&width=%d", self.facebookUID, pixels, pixels]];
}


+ (void)authenticateWithWelcuAccessTokenData:(id)accessTokenData
                           complationHandler:(WelcuAccountAuthenticationCompletionHandler)handler
{
    WelcuAccount *account = [[WelcuAccount alloc] initWithAccessToken:accessTokenData[@"access_token"]];
    
    [account setAttributes:accessTokenData[@"user"]];
    
    [self setCurrentAccount:account];
    
    handler(account,nil);
}


+ (void)authenticateWithFacebookAccessToken:(NSString *)accessToken
                                    completionHandler:(WelcuAccountAuthenticationCompletionHandler)handler
{
    [WelcuSocialClient authorizeWithFacebookAccessToken:accessToken success:^(id accessTokenData) {
        [self authenticateWithWelcuAccessTokenData:accessTokenData complationHandler:handler];
    } failure:^(NSError *error) {
        handler(nil, error);
    }];
}

+ (void)authenticateWithEmail:(NSString *)email
                  andPassword:(NSString *)password
            completionHandler:(WelcuAccountAuthenticationCompletionHandler)handler
{
    [WelcuSocialClient authorizeWithEmail:email andPassword:password success:^(id accessTokenData) {
        [self authenticateWithWelcuAccessTokenData:accessTokenData
                                               complationHandler:handler];
        
    } failure:^(NSError *error) {
        handler(nil, error);
    }];
}

- (WelcuEvent *)lastActiveEvent
{
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"WelcuEvent"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"participating = YES AND accessedAt != nil"];
    fetchRequest.sortDescriptors = @[
                                [NSSortDescriptor sortDescriptorWithKey:@"accessedAt" ascending:NO]
                                ];
    fetchRequest.fetchLimit = 1;
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        DDLogWarn(@"%@", error);
    }
    
    return [results firstObject];
}

@synthesize accountDocumentsDirectory = _accountDocumentsDirectory;

- (NSURL *)accountDocumentsDirectory
{
    if (_accountDocumentsDirectory) {
        return _accountDocumentsDirectory;
    }
    
    _accountDocumentsDirectory = [NSURL URLWithString: [self.userID stringValue]
                                       relativeToURL:[(WelcuAppDelegate *)[[UIApplication sharedApplication] delegate] applicationDocumentsDirectory]];
    DDLogInfo(@"%@", [_accountDocumentsDirectory path]);
    
    [[NSFileManager defaultManager] createDirectoryAtURL:_accountDocumentsDirectory
                             withIntermediateDirectories:NO
                                              attributes:nil
                                                   error:nil];

    return _accountDocumentsDirectory;
}

#pragma mark - Core Data
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize incrementalStore = __incrementalStore;

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WelcuSocial" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    __incrementalStore = (WelcuSocialIncrementalStore *)[__persistentStoreCoordinator addPersistentStoreWithType:[WelcuSocialIncrementalStore type] configuration:nil URL:nil options:nil error:nil];
    
    NSURL *storeURL = [[self accountDocumentsDirectory] URLByAppendingPathComponent:@"WelcuSocial.sqlite"];
    
    NSDictionary *options = @{
                              NSInferMappingModelAutomaticallyOption : @(YES),
                              NSMigratePersistentStoresAutomaticallyOption: @(YES)
                              };
    
    NSError *error = nil;
    if (![__incrementalStore.backingPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                          configuration:nil
                                                                                    URL:storeURL
                                                                                options:options
                                                                                  error:&error]) {
        DDLogError(@"Unresolved error %@, %@", error, [error userInfo]);
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        abort();
    }
    
    DDLogInfo(@"SQLite URL: %@", storeURL);
    
    return __persistentStoreCoordinator;
}

- (void)saveContext
{
    [self.managedObjectContext performBlock:^{
        [self.managedObjectContext save:nil];
    }];
}


@end
