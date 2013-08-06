//
//  WelcuComposeToggleSwitch.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuComposeToggleSwitch.h"

#import <TTSwitch/TTSwitchSubclass.h>
#import <FontasticIcons/FontasticIcons.h>

#import "RetinaAwareUIGraphicsBeginImageContext.h"

@interface WelcuComposeToggleSwitch ()
@property (strong,readonly) UIImage *onThumbImage;
@property (strong,readonly) UIImage *offThumbImage;
@property (strong,readonly) UIImage *trackImage;
@end

@implementation WelcuComposeToggleSwitch

@synthesize onThumbImage = _onThumbImage;
@synthesize offThumbImage = _offThumbImage;
@synthesize trackImage = _trackImage;

- (id)initWithIcon:(FIIcon *)icon andHighlightColor:(UIColor *)highlightColor;
{
    self = [super initWithFrame:CGRectMake(0, 0, 50, 25)];
    if (self) {
        self.icon = icon;
        self.highlightColor = highlightColor;
        
        self.trackMaskImage = [UIImage imageNamed:@"ComposeToggleSwitchMask"];
        self.overlayImage = [UIImage imageNamed:@"ComposeToggleSwitchOverlay"];
        self.trackImageOn = [UIImage imageWithColor:self.highlightColor andSize:CGSizeMake(25, 25)];
        self.trackImageOff = [UIImage imageWithColor:[UIColor whiteColor] andSize:CGSizeMake(25, 25)];

        self.thumbOffsetY = -4;
        self.thumbInsetX = -3;

    }
    return self;
}

+ (WelcuComposeToggleSwitch *)facebookToggleSwitch
{
    return [[WelcuComposeToggleSwitch alloc] initWithIcon:[FIFontAwesomeIcon facebookSignIcon]
                                        andHighlightColor:[UIColor colorWithRed:0.295 green:0.397 blue:0.640 alpha:1.000]];
}

+ (WelcuComposeToggleSwitch *)twitterToggleSwitch
{
    return [[WelcuComposeToggleSwitch alloc] initWithIcon:[FIFontAwesomeIcon twitterSignIcon]
                                        andHighlightColor:[UIColor colorWithRed:0.000 green:0.675 blue:0.929 alpha:1.000]];
}


#define THUMB_SIZE 33
#define THUMB_ICON_MARGIN 6

- (UIImage *)onThumbImage
{
    if (_onThumbImage) {
        return _onThumbImage;
    }
    
    UIImage *baseThumbImage = [UIImage imageNamed:@"ComposeToggleSwitchThumb"];
    UIImage *iconImage = [self.icon imageWithBounds:CGRectMake(0,0,THUMB_SIZE-THUMB_ICON_MARGIN*2,THUMB_SIZE-THUMB_ICON_MARGIN*2)
                                              color:self.highlightColor];
    
    RetinaAwareUIGraphicsBeginImageContext( CGSizeMake(THUMB_SIZE, THUMB_SIZE) );
    [baseThumbImage drawInRect:CGRectMake(0,0,THUMB_SIZE,THUMB_SIZE)];
    [iconImage drawInRect:CGRectMake(THUMB_ICON_MARGIN,THUMB_ICON_MARGIN,THUMB_SIZE-THUMB_ICON_MARGIN*2,THUMB_SIZE-THUMB_ICON_MARGIN*2)];
    
    _onThumbImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return _onThumbImage;
}

- (UIImage *)offThumbImage
{
    if (_offThumbImage) {
        return _offThumbImage;
    }
    
    UIImage *baseThumbImage = [UIImage imageNamed:@"ComposeToggleSwitchThumb"];
    UIImage *iconImage = [self.icon imageWithBounds:CGRectMake(0,0,THUMB_SIZE-THUMB_ICON_MARGIN*2,THUMB_SIZE-THUMB_ICON_MARGIN*2)
                                              color:[UIColor blackColor]];
    
    RetinaAwareUIGraphicsBeginImageContext( CGSizeMake(THUMB_SIZE, THUMB_SIZE) );
    [baseThumbImage drawInRect:CGRectMake(0,0,THUMB_SIZE,THUMB_SIZE)];
    [iconImage drawInRect:CGRectMake(THUMB_ICON_MARGIN,THUMB_ICON_MARGIN,THUMB_SIZE-THUMB_ICON_MARGIN*2,THUMB_SIZE-THUMB_ICON_MARGIN*2)];
    
    _offThumbImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return _offThumbImage;
}

- (UIImage *)trackImage
{
    if (_trackImage) {
        return _trackImage;
    }
    
    return _trackImage;
}

- (void)didMoveThumbCenterToX:(CGFloat)newThumbCenterX
{
    [super didMoveThumbCenterToX:newThumbCenterX];
    
    if ([self isOn]) {
        self.thumbImage = self.onThumbImage;
    } else {
        self.thumbImage = self.offThumbImage;
    }
}



@end
