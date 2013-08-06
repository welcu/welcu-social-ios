//
//  RetinaAwareUIGraphicsBeginImageContext.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "RetinaAwareUIGraphicsBeginImageContext.h"

void RetinaAwareUIGraphicsBeginImageContext(CGSize size) {
    
    static CGFloat scale = -1.0;
    
    if (scale<0.0) {
        
        UIScreen *screen = [UIScreen mainScreen];
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0) {
            
            scale = [screen scale];
            
        }
        
        else {
            
            scale = 0.0;    // mean use old api
            
        }
        
    }
    
    if (scale>0.0) {
        
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
        
    }
    
    else {
        
        UIGraphicsBeginImageContext(size);
        
    }
    
}