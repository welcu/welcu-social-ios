//
//  WelcuMainViewController.m
//  Welcu Social
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuMainViewController.h"

@interface WelcuMainViewController ()
@property (strong) UINavigationController *mainNavigation;
@end

@implementation WelcuMainViewController

-(void) awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"WelcuMenuViewController"]];
    
    self.mainNavigation = [[UINavigationController alloc] init];
    
    [self setCenterPanel:self.mainNavigation];
    
    [self.mainNavigation setViewControllers:@[
                                             [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuEventViewController"]
                                             ]];
    
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
