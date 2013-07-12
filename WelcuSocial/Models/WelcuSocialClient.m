//
//  WelcuSocialClient.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuSocialClient.h"

static NSString * const kWelcuSocialClientAPIBaseURLString = @"https://api.welcu.com/social/v1";

@implementation WelcuSocialClient

- (instancetype)initWithAccount:(WelcuAccount *)account
{
    self = [super initWithBaseURL:[NSURL URLWithString:kWelcuSocialClientAPIBaseURLString]];
    if (self) {
        self.account = account;
        
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
        [self setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"Bearer %@", @"ASDF"]];
    }
    return self;
}

#pragma mark - AFIncrementalStore

@end
