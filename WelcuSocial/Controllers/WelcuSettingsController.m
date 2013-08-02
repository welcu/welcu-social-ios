//
//  WelcuSettingsControllerViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/2/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuSettingsController.h"

#import <InAppSettingsKit/IASKAppSettingsViewController.h>

#import "WelcuAccount.h"

@class WelcuAppSettingsViewController;

@interface WelcuSettingsController () <IASKSettingsDelegate>

@property (nonatomic,strong) IASKAppSettingsViewController *settingsController;

@end

@implementation WelcuSettingsController

+ (WelcuSettingsController *)settingsController
{
    return [[WelcuSettingsController alloc] init];
}

- (id)init
{
    self = [super init];
    if (!self) return nil;

    self.settingsController = [[IASKAppSettingsViewController alloc] init];
    self.settingsController.delegate = self;
    self.settingsController.showCreditsFooter = NO;
    
    self.viewControllers = @[self.settingsController];

    return self;
}

#pragma mark - IASKSettingsDelegate

- (void)settingsViewControllerDidEnd:(IASKAppSettingsViewController *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)settingsViewController:(IASKAppSettingsViewController*)sender buttonTappedForSpecifier:(IASKSpecifier*)specifier
{
    if ([[specifier key] isEqualToString:@"LogOut"]) {
       [[WelcuAccount currentAccount] signOut];
    }
}

@end
