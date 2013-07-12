//
//  WelcuSocialClient.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFIncrementalStore/AFRESTClient.h>

@class WelcuAccount;

@interface WelcuSocialClient : AFRESTClient <AFIncrementalStoreHTTPClient>

@property (weak) WelcuAccount *account;

- (instancetype)initWithAccount:(WelcuAccount *)account;

@end
