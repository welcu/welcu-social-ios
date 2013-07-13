//
//  WelcuFeedPostTextCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventPostTextCell.h"
#import "WelcuPost.h"

@implementation WelcuEventPostTextCell

- (void)awakeFromNib
{
    self.postContentLabel.numberOfLines = 0;
    self.postContentLabel.lineBreakMode = NSLineBreakByCharWrapping;

    self.postContentLabel.font = [UIFont fontWithName:@"GothamLight" size:17];
    
    self.postContentLabel.textColor = [UIColor welcuDarkGrey];
    self.postContentLabel.mentionTextColor =
        self.postContentLabel.hashtagTextColor =
        self.postContentLabel.linkTextColor = [UIColor welcuPurple];
}

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
    
    // Set post content string
    [self.postContentLabel setString:post.content];
}

+ (CGFloat)rowHeightForPost:(WelcuPost *)post
{
    return 100;
}

@end
