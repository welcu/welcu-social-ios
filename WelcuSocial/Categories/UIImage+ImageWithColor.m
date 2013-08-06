//
//  UIImage+ImageWithColor.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "UIImage+ImageWithColor.h"
#import "RetinaAwareUIGraphicsBeginImageContext.h"

@implementation UIImage (ImageWithColor)

// Taken from http://stackoverflow.com/a/993159/1987429
+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [UIImage imageWithColor:color andSize:CGSizeMake(1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    RetinaAwareUIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
