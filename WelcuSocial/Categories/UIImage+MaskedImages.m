//
//  UIImage+MaskedImages.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/29/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "UIImage+MaskedImages.h"

@implementation UIImage (MaskedImages)

// Taken from http://iosdevelopertips.com/cocoa/how-to-mask-an-image.html
- (UIImage*) maskWithImage:(UIImage *)maskImage {

	CGImageRef maskRef = maskImage.CGImage;

	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);

	CGImageRef masked = CGImageCreateWithMask([self CGImage], mask);
	return [UIImage imageWithCGImage:masked];

}
@end
