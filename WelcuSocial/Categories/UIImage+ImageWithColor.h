//
//  UIImage+ImageWithColor.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageWithColor)
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
@end
