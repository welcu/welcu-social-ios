//
//  WelcuFeedPostQuoteCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventPostQuoteCell.h"

@implementation WelcuEventPostQuoteCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

# pragma mark WelcuFeedPostCell
@synthesize post = _post;

- (void)setPost:(WelcuPost *)post
{
    _post = post;
    
    // Do something
    
}

+ (CGFloat)rowHeightForPost:(WelcuPost *)post
{
    return 0;
}

@end
