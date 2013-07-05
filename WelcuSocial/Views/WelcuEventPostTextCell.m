//
//  WelcuFeedPostTextCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventPostTextCell.h"

@implementation WelcuEventPostTextCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)awakeFromNib
{
    self.postContentLabel.numberOfLines = 0;
    self.postContentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    

}

# pragma mark WelcuFeedPostCell
@synthesize post = _post;

- (void)setPost:(WelcuPost *)post
{
    _post = post;
    
    // Set post content string
    [self.postContentLabel setString:@"Hello #world from @twitter http://welcu.com"];
    
}

+ (CGFloat)rowHeightForPost:(WelcuPost *)post
{
    return 100;
}

@end
