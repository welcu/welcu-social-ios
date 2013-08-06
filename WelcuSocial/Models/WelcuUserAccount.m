//
//  WelcuUserAccount.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/2/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuUserAccount.h"

#import <FXKeychain/FXKeychain.h>
#import <FacebookSDK/FacebookSDK.h>

#import "WelcuAppDelegate.h"

@interface WelcuUserAccount ()

@property (strong) NSString *accessToken;
@property (strong, nonatomic) NSMutableDictionary *attributes;
@end

@implementation WelcuUserAccount

#pragma mark - Account Methods

@synthesize attributes = _attributes;

- (id)initWithAccessToken:(NSString *)accessToken
{
    self = [super init];
    if (self) {
        self.accessToken = accessToken;
        
        // Handle Facebook session
        [FBSession.activeSession openWithCompletionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
            
        }];
    }
    return self;
}

- (NSString *)userID
{
    return self.attributes[@"id"];
}

- (NSString *)firstName
{
    return self.attributes[@"first_name"];
}

- (NSString *)lastName
{
    return self.attributes[@"last_name"];
}

- (NSString *)facebookUID
{
    return self.attributes[@"facebook_uid"];
}

- (NSURL *)pictureURLWithSize:(NSInteger)pixels
{
    if (self.facebookUID) {
        pixels = pixels * [[UIScreen mainScreen] scale];
        return [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?height=%d&width=%d", self.facebookUID, pixels, pixels]];
    }
    
    return nil;
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
        [account setAttributes:[keychain[@"user"] mutableCopy]];
        
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

#pragma mark - Sharing

#define FacebookEnabledKey @"FacebookEnabledKey"
- (BOOL)isFacebookEnabled
{
    if (![self isFacebookAuthorized]) {
        return NO;
    }
    
    if (self.attributes[FacebookEnabledKey]) {
        return [self.attributes[FacebookEnabledKey] boolValue];
    }
    
    return YES;
}

- (void)setFacebookEnabled:(BOOL)facebookEnabled
{
    self.attributes[FacebookEnabledKey] = @(facebookEnabled);
}

- (BOOL)isFacebookAuthorized
{
    return [FBSession.activeSession.accessTokenData.permissions indexOfObject:@"publish_actions"] != NSNotFound;
}

- (void)authorizeFacebookWithCompletionHandler:(WelcuUserAuthorizationHandler)completionHandler
{
    if ([self isFacebookAuthorized]) {
        completionHandler(YES,nil);
    } else {
        // Request Facebook write permission
        [[FBSession activeSession] requestNewPublishPermissions:@[@"publish_actions"]
                                                defaultAudience:FBSessionDefaultAudienceEveryone
                                              completionHandler:^(FBSession *session, NSError *error)
         {
             if (error) {
                 completionHandler(NO, error);
             } else {
                 // TODO: Save the info on the account object
                 completionHandler(YES, nil);
             }
         }];
    }
}

#define TwitterEnabledKey @"TwitterEnabledKey"
- (BOOL)isTwitterEnabled
{
    if (![self isTwitterAuthorized]) {
        return NO;
    }
    
    if (self.attributes[TwitterEnabledKey]) {
        return [self.attributes[TwitterEnabledKey] boolValue];
    }
    
    return YES;
}

- (void)setTwitterEnabled:(BOOL)twitterEnabled
{
    self.attributes[TwitterEnabledKey] = @(twitterEnabled);
}

- (BOOL)isTwitterAuthorized
{
    return NO;
}


- (void)authorizeTwitterWithCompletionHandler:(WelcuUserAuthorizationHandler)completionHandler
{
    if ([self isTwitterAuthorized]) {
        completionHandler(YES,nil);
    } else {
        ACAccountStore *accountStore = [[ACAccountStore alloc] init];
        ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
        
        [[[ACAccountStore alloc] init] requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error) {
            if (error) {
                completionHandler(NO,error);
            } else {
                completionHandler(NO,nil);
                // TODO: Save the info on the account object
                NSLog(@"Accounts %@", accountStore.accounts);
            }
        }];
    }
}


@end
