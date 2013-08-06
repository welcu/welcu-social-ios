//
//  WelcuUser.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuUser.h"
#import "WelcuPost.h"
#import "WelcuGuestAccount.h"

#define DEFAULT_PICTURE_SIZE 52

@implementation WelcuUser

@dynamic firstName;
@dynamic lastName;
@dynamic facebookUID;
@dynamic posts;

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
    if (self.facebookUID) {
        pixels = pixels * [[UIScreen mainScreen] scale];
        return [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?height=%d&width=%d", self.facebookUID, pixels, pixels]];
    } else {
        return [WelcuGuestAccount guestPictureURLWithSize:pixels];
    }
}

@end
