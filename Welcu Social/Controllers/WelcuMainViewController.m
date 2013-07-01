//
//  WelcuMainViewController.m
//  Welcu Social
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuMainViewController.h"

@interface WelcuMainViewController ()
@end

@implementation WelcuMainViewController

-(void) awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"WelcuMenuViewController"]];
    [self setCenterPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"WelcuEventFeedNavigationController"]];
    
//    [self setRightPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"rightViewController"]];
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
