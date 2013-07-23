//
//  WelcuFeedPostPhotoCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventPostPhotoCell.h"
#import "WelcuPost.h"

@implementation WelcuEventPostPhotoCell

- (void)awakeFromNib
{

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
    
    [self.postPhotoView setImageWithContentsOfURL:[NSURL URLWithString:post.photo]
                                 placeholderImage:nil];
}

+ (CGFloat)rowHeightForPost:(WelcuPost *)post
{
    return 320;
}

@end
