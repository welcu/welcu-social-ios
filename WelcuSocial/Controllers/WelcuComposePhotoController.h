//
//  WelcuComposePhotoController.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/17/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WelcuComposeController.h"

@interface WelcuComposePhotoController : NSObject

@property (nonatomic, weak) id<WelcuComposeControllerDelegate> delegate;


+ (WelcuComposePhotoController *)composePhotoController;

-(void)presentComposeControllerOn:(UIViewController *)controller;

@end
