//
//  WelcuEventHeaderView.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventHeaderView.h"
#import <GPUImage/GPUImage.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <AFNetworking/AFImageRequestOperation.h>
#import "UIImage+MaskedImages.h"
#import "WelcuEvent.h"

static UINib *viewNib;

@interface WelcuEventHeaderView ()
- (void)setHeaderImage:(UIImage *)image;
@end

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

- (void)awakeFromNib
{
    self.eventNameLabel.font = [UIFont fontWithName:@"MuseoSans-700" size:25];
    self.eventVenueLabel.font = [UIFont fontWithName:@"MuseoSans-300" size:15];
    self.eventDateLabel.font = [UIFont fontWithName:@"MuseoSans-300" size:15];
}

- (void)setEvent:(WelcuEvent *)event
{
    _event = event;
    
    self.eventNameLabel.text = event.name;
    
    if (event.venueName) {
        self.eventVenueLabel.text = event.venueName;
    } else if (event.venueAddress) {
        self.eventVenueLabel.text = event.venueAddress;
    }
    
    self.eventDateLabel.text = event.formattedDateRange;
    
    [self setHeaderImage:[UIImage imageNamed:@"DefaultEventHeader"]];
    if (event.headerPhoto) {
        NSURLRequest *request = [NSURLRequest requestWithURL:event.headerPhotoURL];
        
        AFImageRequestOperation *headerFetch = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image) {
            [self setHeaderImage:image];
        }];
        
        [headerFetch start];
    }
}

- (void)setHeaderImage:(UIImage *)image
{
    // Generate Event photo image
    UIImage *eventPhotoImage = image;
    eventPhotoImage = [eventPhotoImage imageByScalingAndCroppingForSize:CGSizeMake(228, 228)];
    eventPhotoImage = [eventPhotoImage maskWithImage:[UIImage imageNamed:@"EventHeaderPhotoMask"]];
    self.eventPhotoView.image = eventPhotoImage;
    
    // Generate Event background image
    UIImage *eventBackgroundImage = image;
    
    //    GPUImageFilterGroup *filter = [[GPUImageFilterGroup alloc] init];
    
    GPUImageFastBlurFilter *blurFilter = [[GPUImageFastBlurFilter alloc] init];
    blurFilter.blurPasses = 5;
    //    [filter addFilter:blurFilter];
    
    GPUImageHighlightShadowFilter *shadowFilter = [[GPUImageHighlightShadowFilter alloc] init];
    shadowFilter.highlights = 0.7;
    //    [filter addFilter:shadowFilter];
    
    //    self.eventBackgroundView.image = eventBackgroundImage;
    self.eventBackgroundView.image = [shadowFilter imageByFilteringImage:[blurFilter imageByFilteringImage:eventBackgroundImage]];
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
