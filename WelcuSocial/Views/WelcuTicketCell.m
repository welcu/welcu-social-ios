//
//  WelcuTicketCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuTicketCell.h"

@implementation WelcuTicketCell

@synthesize ticket = _ticket;

- (void)setTicket:(WelcuTicket *)ticket
{
    _ticket = ticket;
    [self setContent];
}

+ (UIFont *)boldFont
{
    return nil;
}

+ (UIFont *)lightFont
{
    return nil;
}

+ (UIFont *)lighterFont
{
    return nil;
}

+ (UIColor *)blackColor
{
    return nil;
}

+ (UIColor *)greyColor
{
    return nil;
}

- (void)setContent
{
}

@end
