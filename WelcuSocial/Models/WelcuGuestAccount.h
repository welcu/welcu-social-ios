//
//  WelcuGuestAccount.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/2/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "WelcuAccount.h"

@interface WelcuGuestAccount : WelcuAccount

+ (WelcuGuestAccount *)guestAccount;
+ (NSURL *)guestDocumentsDirectory;
+ (NSURL *)guestPictureURLWithSize:(NSInteger)pixels;

@end
