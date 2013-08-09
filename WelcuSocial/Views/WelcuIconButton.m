//
//  WelcuComposeButton.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/9/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuIconButton.h"

@implementation WelcuIconButton

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame icon:nil color:nil];
}

- (id)initWithFrame:(CGRect)frame icon:(FIIcon *)icon
{
    return [self initWithFrame:frame icon:icon color:nil];
}

- (id)initWithFrame:(CGRect)frame icon:(FIIcon *)icon color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.icon = icon;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

@end
