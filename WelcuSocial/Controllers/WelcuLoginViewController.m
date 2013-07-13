//
//  WelcuLoginViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

#import "WelcuStartViewController.h"

@interface WelcuLoginViewController ()

@end

@implementation WelcuLoginViewController

- (void)loginFailed
{
    
}

- (IBAction)loginButtonPressed:(id)sender
{
    [(WelcuStartViewController *)self.presentingViewController openSession];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
