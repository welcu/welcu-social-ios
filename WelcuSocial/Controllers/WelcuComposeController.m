//
//  WelcuComposeViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/1/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuComposeController.h"

@interface WelcuComposeController ()

- (void)cancelComposeAction:(id)sender;

@end

@implementation WelcuComposeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = self.view.frame;
    rect.size.height = rect.size.height - 50;
    rect.size.width = rect.size.width - 50;
    
    self.view.frame = rect;
    
    
    rect = self.navigationBar.frame;
    rect.origin.y = rect.origin.y - 10;
    self.navigationBar.frame = rect;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelComposeAction:)];
    UIViewController *firstController = (UIViewController *)[self.viewControllers firstObject];
    firstController.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)cancelComposeAction:(id)sender
{
    [self.composeDelegate composeControllerDidCancel:self];
}

@end
