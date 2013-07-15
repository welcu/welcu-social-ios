//
//  WelcuStartViewController.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcuStartViewController : UIViewController

#pragma mark View handling
- (void)presentMainViewAnimated:(BOOL)animated;
- (void)dissmisMainViewAnimated:(BOOL)animated;
- (void)presentLoginViewAnimated:(BOOL)animated;
- (void)dissmisLoginViewAnimated:(BOOL)animated;

@end
