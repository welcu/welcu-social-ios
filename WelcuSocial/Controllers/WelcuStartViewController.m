//
//  WelcuStartViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuStartViewController.h"

#import <FacebookSDK/FacebookSDK.h>

#import "WelcuAccount.h"
#import "WelcuLoginViewController.h"
#import "WelcuMainViewController.h"

@interface WelcuStartViewController ()

@end

@implementation WelcuStartViewController

#pragma mark View handling

- (void)presentMainViewAnimated:(BOOL)animated
{
    [self dissmisLoginViewAnimated:animated];
    
    if (![self.presentedViewController isKindOfClass:[WelcuMainViewController class]]) {
        [self performSegueWithIdentifier:@"WelcuMainViewController" sender:self];
    }
}

- (void)dissmisMainViewAnimated:(BOOL)animated
{
    if (![self.presentedViewController isKindOfClass:[WelcuMainViewController class]]) {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}

- (void)presentLoginViewAnimated:(BOOL)animated
{
    [self dissmisMainViewAnimated:animated];
    
    if (![self.presentedViewController isKindOfClass:[WelcuLoginViewController class]]) {
        [self performSegueWithIdentifier:@"WelcuLoginViewController" sender:self];
    } else {
        WelcuLoginViewController* loginViewController =
        (WelcuLoginViewController *)self.presentedViewController;
        [loginViewController loginFailed];
    }
}

- (void)dissmisLoginViewAnimated:(BOOL)animated
{
    if (![self.presentedViewController isKindOfClass:[WelcuLoginViewController class]]) {
        [self dismissViewControllerAnimated:animated completion:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if ([WelcuAccount currentAccount]) {
        [self presentMainViewAnimated:animated];
    } else {
        [self presentLoginViewAnimated:animated];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
