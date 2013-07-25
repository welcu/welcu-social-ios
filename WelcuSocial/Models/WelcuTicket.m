//
//  WelcuTicket.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuTicket.h"
#import "WelcuActivity.h"
#import "WelcuEvent.h"

#import <QRCodeGenerator.h>


@implementation WelcuTicket

@dynamic code;
@dynamic ticketID;
@dynamic checkedAt;
@dynamic personFirstName;
@dynamic personLastName;
@dynamic personEmail;

@dynamic event;
@dynamic activity;


- (NSString *)personFullName
{
    return [NSString stringWithFormat:@"%@ %@", self.personFirstName, self.personLastName];
}

- (UIImage *)qrCodeImage
{
    return [self qrCodeImageWithSize:180];
}

- (UIImage *)qrCodeImageWithSize:(NSInteger)pixels
{
    
    pixels = pixels * [[UIScreen mainScreen] scale];
    return [QRCodeGenerator qrImageForString:self.code imageSize:pixels];
}

@end
