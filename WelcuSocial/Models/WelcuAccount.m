//
//  WelcuAccount.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuAccount.h"


#import "WelcuGuestAccount.h"
#import "WelcuUserAccount.h"
#import "WelcuSocialIncrementalStore.h"
#import "WelcuAppDelegate.h"

#define DEFAULT_PICTURE_SIZE 52

static WelcuAccount *currentAccount = nil;

@interface WelcuAccount ()

@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) WelcuSocialIncrementalStore *incrementalStore;

@end

@implementation WelcuAccount

#pragma mark - Authentication

+ (WelcuAccount *)currentAccount
{
    @synchronized(self) {
        if (!currentAccount) {
            // Load persisted account data
            WelcuUserAccount *account = [WelcuUserAccount authenticatedAccount];
            if (account) {
                currentAccount = account;
            } else {
                currentAccount = [WelcuGuestAccount guestAccount];
            }
        }
    }
    
    return currentAccount;
}

- (void)signOut
{
    if ([currentAccount isGuest]) return;
    
    currentAccount = [WelcuGuestAccount guestAccount];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WelcuAccountSignOut" object:nil];
}

- (void)signIn
{
    currentAccount = self;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"WelcuAccountSignIn" object:nil];
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

#pragma mark - Abstract Methods

#define ABSTRACT @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)] userInfo:nil];

#pragma mark - Abstract Methods

- (NSNumber *)userID { ABSTRACT }
- (NSString *)firstName { ABSTRACT }
- (NSString *)lastName { ABSTRACT }
- (NSString *)facebookUID { ABSTRACT }
- (BOOL)isGuest { ABSTRACT }
- (NSURL *)pictureURLWithSize:(NSInteger)pixels { ABSTRACT }
- (WelcuEvent *)lastActiveEvent { ABSTRACT }
- (NSURL *)accountDocumentsDirectory { ABSTRACT }

#pragma mark - Account Methods

@synthesize client = _client;

- (WelcuSocialClient *)client
{
    if (!_client) {
        _client = [[WelcuSocialClient alloc] initWithAccount:self];
    }
    
    return _client;
}

- (NSString *)fullName
{
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (NSURL *)pictureURL
{
    return [self pictureURLWithSize:DEFAULT_PICTURE_SIZE];
}


@end
