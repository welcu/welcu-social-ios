//
//  WelcuEventTicketsCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventTicketsCell.h"

@implementation WelcuEventTicketsCell

@synthesize event = _event;

- (void)setEvent:(WelcuEvent *)event
{
    _event = event;
    
    self.textLabel.text = event.name;
    self.detailTextLabel.text = [event fromDateToDateString];
}


@end
