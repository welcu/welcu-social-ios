//
//  WelcuComposeButton.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/9/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FontasticIcons/FontasticIcons.h>

@interface WelcuIconButton : UIButton

@property (nonatomic,strong) FIIcon *icon;

- (id)initWithFrame:(CGRect)frame icon:(FIIcon *)icon;
- (id)initWithFrame:(CGRect)frame icon:(FIIcon *)icon color:(UIColor *)color;

@end
