//
//  UIColor+WelcuColors.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "UIColor+WelcuColors.h"

@implementation UIColor (WelcuColors)

+ (UIColor *)welcuPurple
{
    return [UIColor colorWithRed:0.329 green:0.333 blue:0.557 alpha:1.000];
}

+ (UIColor *)welcuLightPurple
{
    // #cccbff
    return [UIColor colorWithRed:0.329 green:0.325 blue:0.565 alpha:1];
}

+ (UIColor *)welcuGreen
{
    // #0bb475
    // 4.3, 70.6, 45.9
    return [UIColor colorWithRed:0.043 green:0.706 blue:0.459 alpha:1.000];
}

+ (UIColor *)welcuDarkGreen
{
    // #0aa169
    return [UIColor colorWithRed:0.329 green:0.325 blue:0.565 alpha:1];
}

+ (UIColor *)welcuRed
{
    // #ff6b4c
    return [UIColor colorWithRed:0.329 green:0.325 blue:0.565 alpha:1];
}

+ (UIColor *)welcuYelow
{
    // #ecba41
    return [UIColor colorWithRed:0.329 green:0.325 blue:0.565 alpha:1];
}

+ (UIColor *)welcuLightGrey
{
    return [UIColor colorWithWhite:0.961 alpha:1];
}

+ (UIColor *)welcuMediumGrey
{
    return [UIColor colorWithWhite:0.667 alpha:1];
}

+ (UIColor *)welcuDarkGrey
{
    return [UIColor colorWithWhite:0.60 alpha:1];
}

+ (UIColor *)facebookBlue
{
    return [UIColor colorWithRed:0.298 green:0.400 blue:0.643 alpha:1.000];
}

+ (UIColor *)twitterBlue
{
    return [UIColor colorWithRed:0.000 green:0.675 blue:0.929 alpha:1.000];
}

@end
