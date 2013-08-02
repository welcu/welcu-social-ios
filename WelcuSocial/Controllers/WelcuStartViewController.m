//
//  WelcuStartViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuStartViewController.h"
#import "WelcuAccount.h"

@interface WelcuStartViewController ()

@end

@implementation WelcuStartViewController

#pragma mark View handling

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAccountChange) name:@"WelcuAccountSignIn" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAccountChange) name:@"WelcuAccountSignOut" object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self performSegueWithIdentifier:@"WelcuMainViewController" sender:self];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)handleAccountChange
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
