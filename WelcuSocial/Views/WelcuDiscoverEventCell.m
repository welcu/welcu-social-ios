//
//  WelcuDiscoverEventCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/26/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuDiscoverEventCell.h"

@implementation WelcuDiscoverEventCell

@synthesize event = _event;

- (void)setEvent:(WelcuEvent *)event
{
    _event = event;
    self.eventNameLabel.text = event.name;
    self.eventDateLabel.text = [event fromDateToDateString];

    if (event.headerPhotoURL) {
        [self.eventFlyerImage setImageWithContentsOfURL:event.headerPhotoURL
                                       placeholderImage:[UIImage imageNamed:@"DefaultEventHeader"]];
    } else {
        self.eventFlyerImage.image = [UIImage imageNamed:@"DefaultEventHeader"];
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
