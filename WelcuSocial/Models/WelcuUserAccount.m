//
//  WelcuUserAccount.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/2/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuUserAccount.h"

#import <FXKeychain/FXKeychain.h>

#import "WelcuAppDelegate.h"

@interface WelcuUserAccount ()

@property (strong) NSString *accessToken;
@property (strong, nonatomic) NSDictionary *attributes;

@property (strong) NSNumber *userID;
@property (strong) NSString *firstName;
@property (strong) NSString *lastName;
@property (strong) NSString *facebookUID;

@end

@implementation WelcuUserAccount

#pragma mark - Account Methods

@synthesize userID = _userID;
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize facebookUID = _facebookUID;

- (id)initWithAccessToken:(NSString *)accessToken
{
    self = [super init];
    if (self) {
        self.accessToken = accessToken;
    }
    return self;
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


- (NSURL *)pictureURLWithSize:(NSInteger)pixels
{
    
    pixels = pixels * [[UIScreen mainScreen] scale];
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?height=%d&width=%d", self.facebookUID, pixels, pixels]];
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

- (BOOL)isGuest
{
    return NO;
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

#pragma mark - Authentication

+ (WelcuUserAccount *)authenticatedAccount
{
    FXKeychain *keychain = [FXKeychain defaultKeychain];
    
    if (keychain[@"access_token"]) {
        WelcuUserAccount *account = [[WelcuUserAccount alloc] initWithAccessToken:keychain[@"access_token"]];
        [account setAttributes:keychain[@"user"]];
        
        return account;
    }
    
    return nil;
}

- (void)signIn
{
    FXKeychain *keychain = [FXKeychain defaultKeychain];
    
    keychain[@"access_token"] = self.accessToken;
    keychain[@"user"] = self.attributes;
    
    [super signIn];
}

- (void)signOut
{
    FXKeychain *keychain = [FXKeychain defaultKeychain];
    
    keychain[@"access_token"] = nil;
    keychain[@"user"] = nil;

    [super signOut];
}

+ (void)authenticateWithWelcuAccessTokenData:(id)accessTokenData
                           complationHandler:(WelcuAccountAuthenticationCompletionHandler)handler
{
    WelcuUserAccount *account = [[WelcuUserAccount alloc] initWithAccessToken:accessTokenData[@"access_token"]];
    
    [account setAttributes:accessTokenData[@"user"]];
    
    [account signIn];
    
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

@end
