//
//  WelcuFeedPostHeaderView.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventPostHeaderView.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

#import "UIImage+MaskedImages.h"
#import "WelcuPost.h"
#import "WelcuUser.h"

//NSString const *kWelcuEventPostHeaderViewClassName = @"WelcuEventPostHeaderView";

@implementation WelcuEventPostHeaderView


# pragma mark WelcuFeedPostCell
@synthesize post = _post;

- (void)awakeFromNib
{
    self.userNameLabel.font = [UIFont fontWithName:@"GothamMedium" size:17];
}

- (void)setPost:(WelcuPost *)post
{
    _post = post;
    
    // Set post user name
    self.userNameLabel.text = post.user.fullName;
    
    // Load post user image
    NSURLRequest *request = [NSURLRequest requestWithURL:post.user.pictureURL];
    [self.userImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.userImageView.image = [image maskWithImage:[UIImage imageNamed:@"UserPhotoMask"]];
    } failure:nil];
}

+ (CGFloat)rowHeightForPost:(WelcuPost *)post
{
    return 64;
}

@end
