//
//  WelcuComposeToggleSwitch.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "TTFadeSwitch.h"

@class FIIcon;

@interface WelcuComposeToggleSwitch : TTFadeSwitch

@property (nonatomic,strong) FIIcon *icon;
@property (nonatomic,strong) UIColor *highlightColor;

- (id)initWithIcon:(FIIcon *)icon andHighlightColor:(UIColor *)highlightColor;

+ (WelcuComposeToggleSwitch *)facebookToggleSwitch;
+ (WelcuComposeToggleSwitch *)twitterToggleSwitch;

@end
