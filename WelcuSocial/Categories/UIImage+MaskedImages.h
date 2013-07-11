//
//  UIImage+MaskedImages.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/29/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MaskedImages)

- (UIImage*) maskWithImage:(UIImage *)maskImage;
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;

@end
