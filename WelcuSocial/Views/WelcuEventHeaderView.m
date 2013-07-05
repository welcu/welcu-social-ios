//
//  WelcuEventHeaderView.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventHeaderView.h"

static UINib *viewNib;

@implementation WelcuEventHeaderView

@synthesize event = _event;

+ (WelcuEventHeaderView *)headerView
{
    if (!viewNib) {
        viewNib = [UINib nibWithNibName:@"WelcuEventHeaderView" bundle:nil];
    }
    
    WelcuEventHeaderView *header = [[viewNib instantiateWithOwner:nil options:nil] firstObject];
    
    return header;
}

- (void)setEvent:(WelcuEvent *)event
{
    _event = event;
}

- (void)setHeight:(CGFloat)height
{
    [self setHeight:height animated:NO];
}

- (void)setHeight:(CGFloat)height animated:(BOOL)animated
{
    CGRect frame = self.frame;
    frame.size.height = MAX(WELCU_EVENT_HEADER_MIN_HEIGHT, MIN(WELCU_EVENT_HEADER_MAX_HEIGHT, height));;
    self.frame = frame;
}

@end
