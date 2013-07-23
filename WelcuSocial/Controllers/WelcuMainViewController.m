//
//  WelcuMainViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuMainViewController.h"

#import "WelcuAccount.h"
#import "WelcuEventFeedViewController.h"

@interface WelcuMainViewController ()
@end

@implementation WelcuMainViewController

-(void) awakeFromNib
{
    [self setLeftPanel:[self.storyboard instantiateViewControllerWithIdentifier:@"WelcuMenuViewController"]];
    
    WelcuEvent *lastActiveEvent = [[WelcuAccount currentAccount] lastActiveEvent];
    
    UINavigationController *centerController;
    
    if (lastActiveEvent) {
        centerController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuEventFeedNavigationController"];
        WelcuEventFeedViewController *eventFeedController = [[centerController viewControllers] firstObject];
        eventFeedController.event = lastActiveEvent;
    } else {
        centerController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuUserEventsNavigationController"];
    }
    
    [self setCenterPanel:centerController];
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

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
