//
//  WelcuEventTicketsCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventTicketsCell.h"

#import <FontasticIcons/FontasticIcons.h>

@implementation WelcuEventTicketsCell

@synthesize event = _event;

- (void)awakeFromNib
{
    FIIcon *icon = [FIFontAwesomeIcon ticketIcon];
    self.imageView.image = [icon imageWithBounds:CGRectMake(0, 0, 25, 25) color:[UIColor welcuMediumGrey]];
}

- (void)setEvent:(WelcuEvent *)event
{
    _event = event;
    
    self.textLabel.text = event.name;
    self.detailTextLabel.text = event.formattedDateRange;
}


@end
