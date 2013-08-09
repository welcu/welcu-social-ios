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
    CGFloat size = frame.size.height;
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, size, size)];
    if (self) {
        self.layer.cornerRadius = size/2;
        self.layer.borderWidth = 2;
        self.layer.borderColor = color.CGColor;
        
        self.color = color;
        self.icon = icon;
        [self setImage:[icon imageWithBounds:CGRectMake(0, 0, size-10, size-10)
                                            color:color]
              forState:UIControlStateNormal];
        
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
