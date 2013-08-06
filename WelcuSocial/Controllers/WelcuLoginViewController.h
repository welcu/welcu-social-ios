//
//  WelcuLoginViewController.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcuLoginViewController : UIViewController

@property (weak,nonatomic) IBOutlet UIButton *facebookSignInButton;

- (void)loginFailed;

- (IBAction)dismissLogin:(id)sender;
- (IBAction)loginButtonPressed:(id)sender;

@end
