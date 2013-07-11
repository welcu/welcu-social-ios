//
//  WelcuEventHeaderView.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventHeaderView.h"
#import <GPUImage/GPUImage.h>

#import "UIImage+MaskedImages.h"

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
    
    // Generate Event photo image
    UIImage *eventPhotoImage = [UIImage imageNamed:@"SampleEventImage"];
    eventPhotoImage = [eventPhotoImage imageByScalingAndCroppingForSize:CGSizeMake(228, 228)];
    eventPhotoImage = [eventPhotoImage maskWithImage:[UIImage imageNamed:@"EventHeaderPhotoMask"]];
    self.eventPhotoView.image = eventPhotoImage;
    
    // Generate Event background image
    UIImage *eventBackgroundImage = [UIImage imageNamed:@"SampleEventImage"];
    
//    GPUImageFilterGroup *filter = [[GPUImageFilterGroup alloc] init];
    
    GPUImageFastBlurFilter *blurFilter = [[GPUImageFastBlurFilter alloc] init];
    blurFilter.blurPasses = 5;
//    [filter addFilter:blurFilter];
    
//    GPUImageHighlightShadowFilter *shadowFilter = [[GPUImageHighlightShadowFilter alloc] init];
//    shadowFilter.highlights = 0.7;
//    [filter addFilter:shadowFilter];
    
    self.eventBackgroundView.image = [blurFilter imageByFilteringImage:eventBackgroundImage];
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
