//
//  WelcuEventCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/30/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventCell.h"

@implementation WelcuEventCell

@synthesize event = _event;

- (void)setEvent:(WelcuEvent *)event
{
    _event = event;
    self.textLabel.text = event.name;
    self.detailTextLabel.text = event.formattedDateRange;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
