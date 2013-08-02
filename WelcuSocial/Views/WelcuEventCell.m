//
//  WelcuEventCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/30/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventCell.h"
#import <FontasticIcons/FontasticIcons.h>

@implementation WelcuEventCell

@synthesize event = _event;

- (void)awakeFromNib
{
    FIIcon *icon = [FIFontAwesomeIcon calendarIcon];
    self.imageView.image = [icon imageWithBounds:CGRectMake(0, 0, 25, 25) color:[UIColor welcuMediumGrey]];
}

- (void)setEvent:(WelcuEvent *)event
{
    _event = event;
    self.textLabel.text = event.name;
    self.detailTextLabel.text = event.formattedDateRange;
}

@end
