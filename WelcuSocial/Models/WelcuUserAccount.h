//
//  WelcuUserAccount.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/2/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuAccount.h"

@class WelcuUserAccount;

typedef void(^WelcuAccountAuthenticationCompletionHandler)(WelcuUserAccount *account, NSError *error);

typedef void(^WelcuUserAuthorizationHandler)(BOOL granted, NSError *error);

@interface WelcuUserAccount : WelcuAccount

#pragma mark - Authentication

+ (WelcuUserAccount *)authenticatedAccount;
+ (void)authenticateWithFacebookAccessToken:(NSString *)accessToken
                          completionHandler:(WelcuAccountAuthenticationCompletionHandler)handler;
+ (void)authenticateWithEmail:(NSString *)email
                  andPassword:(NSString *)password
            completionHandler:(WelcuAccountAuthenticationCompletionHandler)handler;


#pragma mark - Sharing

@property (assign,getter=isFacebookEnabled) BOOL facebookEnabled;
@property (readonly,getter=isFacebookAuthorized) BOOL facebookAuthorized;
- (void)authorizeFacebookWithCompletionHandler:(WelcuUserAuthorizationHandler)completionHandler;

@property (assign,getter=isTwitterEnabled) BOOL twitterEnabled;
@property (readonly,getter=isTwitterAuthorized) BOOL twitterAuthorized;
- (void)authorizeTwitterWithCompletionHandler:(WelcuUserAuthorizationHandler)completionHandler;

@end
