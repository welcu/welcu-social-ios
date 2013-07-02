//
//  WelcuComposeViewController.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/1/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WelcuComposeController;

@protocol WelcuComposeControllerDelegate <NSObject>

- (void)composeControllerDidCancel:(WelcuComposeController *)composeController;

@end

@interface WelcuComposeController : UINavigationController
@property (weak) id<WelcuComposeControllerDelegate> composeDelegate;
@end
