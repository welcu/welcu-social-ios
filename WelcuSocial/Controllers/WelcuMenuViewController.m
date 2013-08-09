//
//  WelcuMenuViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuMenuViewController.h"
#import <JASidePanels/JASidePanelController.h>
#import <JASidePanels/UIViewController+JASidePanel.h>
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <FontasticIcons/FontasticIcons.h>

#import "WelcuIconButton.h"
#import "WelcuSettingsController.h"
#import "WelcuAccount.h"
#import "UIImage+MaskedImages.h"
#import "WelcuMenuUserProfileCell.h"
#import "WelcuMenuActionCell.h"
#import "WelcuFooterView.h"

@interface WelcuMenuViewController ()

@end

@implementation WelcuMenuViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"WelcuMenuUserProfileCell" bundle:nil]
         forCellReuseIdentifier:@"WelcuMenuUserProfileCell"];

    [self.tableView registerNib:[UINib nibWithNibName:@"WelcuMenuActionCell" bundle:nil]
         forCellReuseIdentifier:@"WelcuMenuActionCell"];
    
//    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 50)];
    
    self.tableView.tableFooterView = [WelcuFooterView footerWithFrame:CGRectMake(0, 0, self.view.frame.size.width-40, 200)
                                                                color:[UIColor welcuDarkGrey]
                                                                 text:nil];
    
    FIIcon *settingsIcon;
    SEL settingsSelector;
    if ([[WelcuAccount currentAccount] isGuest]) {
        settingsIcon = [FIFontAwesomeIcon signinIcon];
        settingsSelector = @selector(showLogin:);
    } else {
        settingsIcon = [FIFontAwesomeIcon cogIcon];
        settingsSelector = @selector(showSettings:);
    }
    
    WelcuIconButton *settingsButton = [[WelcuIconButton alloc] initWithFrame:CGRectMake(15,self.view.frame.size.height-50,35,35)
                                                                        icon:settingsIcon
                                                                       color:[UIColor welcuLightGrey]];
    [settingsButton addTarget:self
                       action:settingsSelector
             forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:settingsButton];
    
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-10-[settingsButton]"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:NSDictionaryOfVariableBindings(settingsButton)]];
//
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[settingsButton]-10-|"
//                                                                      options:0
//                                                                      metrics:nil
//                                                                        views:NSDictionaryOfVariableBindings(settingsButton)]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    switch (indexPath.row) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"WelcuMenuUserProfileCell"
                                                   forIndexPath:indexPath];
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"WelcuMenuActionCell"
                                                   forIndexPath:indexPath];
            if ([[WelcuAccount currentAccount] isGuest]) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [(WelcuMenuActionCell*)cell setCellType:WelcuMenuActionCellMyEventsType];
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"WelcuMenuActionCell"
                                                   forIndexPath:indexPath];
            if ([[WelcuAccount currentAccount] isGuest]) {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [(WelcuMenuActionCell*)cell setCellType:WelcuMenuActionCellMyTicketsType];
            break;
        case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"WelcuMenuActionCell"
                                                   forIndexPath:indexPath];
            [(WelcuMenuActionCell*)cell setCellType:WelcuMenuActionCellDiscoverType];
            break;
    }
    
//    UICollectionViewController
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 125;
    }
    
    return 51;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *newController = nil;
    
    switch (indexPath.row) {
        case 1:
            if (![[WelcuAccount currentAccount] isGuest]) {
                newController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuUserEventsNavigationController"];
            }
            break;
        case 2:
            if (![[WelcuAccount currentAccount] isGuest]) {
                newController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuUserTicketsNavigationController"];
            }
            break;
        case 3:
            newController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuDiscoverNavigationController"];
            break;
    }
    
    if (newController) {
        [self pressentMainController:newController];
    }
}

- (void)pressentMainController:(UIViewController *)controller
{
    JASidePanelController *sidePanel = self.sidePanelController;
    
    NSTimeInterval delayInSeconds = 0.2;
    
    [sidePanel setCenterPanelHidden:YES animated:YES duration:delayInSeconds];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [sidePanel setCenterPanel:controller];
        [sidePanel showCenterPanelAnimated:YES];
    });
}


- (void)showLogin:(id)sender
{
    UIViewController *loginController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuLoginNavigationController"];
    [self.sidePanelController presentViewController:loginController animated:YES completion:nil];
}

- (void)showSettings:(id)sender
{
    WelcuSettingsController *settingsController = [WelcuSettingsController settingsController];
//    [self pressentMainController:settingsController];
    [self.sidePanelController presentViewController:settingsController animated:YES completion:nil];
}

@end
