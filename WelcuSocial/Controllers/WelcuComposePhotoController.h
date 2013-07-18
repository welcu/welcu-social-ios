//
//  WelcuComposePhotoController.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/17/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WelcuComposeController.h"

@class WelcuEvent;

@interface WelcuComposePhotoController : NSObject

@property (nonatomic,strong) WelcuEvent *event;
@property (nonatomic, weak) id<WelcuComposeControllerDelegate> delegate;


+ (WelcuComposePhotoController *)composePhotoController;

-(void)presentComposeControllerOn:(UIViewController *)controller;

@end
