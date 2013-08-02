//
//  WelcuGuestAccount.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/2/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuGuestAccount.h"

#import "WelcuAppDelegate.h"

@implementation WelcuGuestAccount

+ (NSURL *)guestDocumentsDirectory
{
    NSURL *guestDocumentsDirectory = [NSURL URLWithString: @"guest"
                                            relativeToURL:[(WelcuAppDelegate *)[[UIApplication sharedApplication] delegate] applicationDocumentsDirectory]];
    
    return guestDocumentsDirectory;
}

+ (NSURL *)guestPictureURLWithSize:(NSInteger)pixels
{
//    FIIcon *icon = [FIFontAwesomeIcon userIcon];
//    return [icon imageWithBounds:CGRectMake(0, 0, pixels, pixels) color:[UIColor whiteColor]];
    return nil;
}


+ (WelcuGuestAccount *)guestAccount
{
    return [[WelcuGuestAccount alloc] init];
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Account Methods

- (NSNumber *)userID
{
    return nil;
}

- (NSString *)firstName
{
    return @"Guest";
}

- (NSString *)lastName
{
    return @"";
}

- (NSString *)facebookUID
{
    return nil;
}

- (NSURL *)pictureURLWithSize:(NSInteger)pixels
{
    return [WelcuGuestAccount guestPictureURLWithSize:pixels];
}

- (WelcuEvent *)lastActiveEvent
{
    return nil;
}

- (NSURL *)accountDocumentsDirectory
{
    NSURL *guestDocumentsDirectory = [WelcuGuestAccount guestDocumentsDirectory];
    
    [[NSFileManager defaultManager] createDirectoryAtURL:guestDocumentsDirectory
                             withIntermediateDirectories:NO
                                              attributes:nil
                                                   error:nil];

    return guestDocumentsDirectory;
}

- (BOOL)isGuest
{
    return YES;
}



@end
