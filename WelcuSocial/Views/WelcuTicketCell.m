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
    return [UIFont fontWithName:@"MuseoSans-700" size:20];
}

+ (UIFont *)lightFont
{
    return [UIFont fontWithName:@"MuseoSans-300" size:15];
}

+ (UIFont *)lighterFont
{
    return [UIFont fontWithName:@"MuseoSans-300" size:10];
}

+ (UIColor *)blackColor
{
    return [UIColor blackColor];
}

+ (UIColor *)greyColor
{
    return [UIColor welcuMediumGrey];
}

- (void)setContent
{
}

@end
