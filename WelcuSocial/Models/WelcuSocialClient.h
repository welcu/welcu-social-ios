//
//  WelcuSocialClient.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFIncrementalStore/AFRESTClient.h>

typedef void(^WelcuSocialClientResponseHandler)(id response, NSError *error);

@class WelcuAccount;

@interface WelcuSocialClient : AFRESTClient <AFIncrementalStoreHTTPClient>

@property (weak) WelcuAccount *account;

- (instancetype)initWithAccount:(WelcuAccount *)account;

+ (void)authorizeWithFacebookAccessToken:(NSString *)accessToken
                                 success:(void (^)(id accessTokenData))success
                                 failure:(void (^)(NSError *error))failure;

+ (void)authorizeWithEmail:(NSString *)email
               andPassword:(NSString *)password
                   success:(void (^)(id accessTokenData))success
                   failure:(void (^)(NSError *error))failure;

#pragma mark Welcu Social API

- (void)fetchMe:(WelcuSocialClientResponseHandler)handler;

@end
