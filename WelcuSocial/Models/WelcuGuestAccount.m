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
    pixels = pixels * [[UIScreen mainScreen] scale];
    return [NSURL URLWithString:[NSString stringWithFormat:@"https://assets.welcu.com/images/accounts/avatar/social-%dpx.png", pixels]];
}

+ (WelcuGuestAccount *)guestAccount
{
    return [[WelcuGuestAccount alloc] init];
}

+ (void)removeGuestDirectoryIfPressent
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[[self guestDocumentsDirectory] path]]) {
        [fileManager removeItemAtURL:[self guestDocumentsDirectory]
                               error:nil];
    }
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
