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

#import "WelcuAccount.h"
#import "UIImage+MaskedImages.h"
#import "WelcuMenuUserProfileCell.h"
#import "WelcuMenuActionCell.h"

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
    
    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
            [(WelcuMenuActionCell*)cell setCellType:WelcuMenuActionCellMyEventsType];
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"WelcuMenuActionCell"
                                                   forIndexPath:indexPath];
            [(WelcuMenuActionCell*)cell setCellType:WelcuMenuActionCellMyTicketsType];
            break;
        case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"WelcuMenuActionCell"
                                                   forIndexPath:indexPath];
            [(WelcuMenuActionCell*)cell setCellType:WelcuMenuActionCellDiscoverType];
            break;
    }
    
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
            newController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuUserEventsNavigationController"];
            break;
        case 2:
            newController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuUserTicketsNavigationController"];
            break;
        case 3:
            newController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuDiscoverNavigationController"];
            break;
    }
    
    if (newController) {
        JASidePanelController *sidePanel = self.sidePanelController;
        
        NSTimeInterval delayInSeconds = 0.2;
        
        [sidePanel setCenterPanelHidden:YES animated:YES duration:delayInSeconds];
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [sidePanel setCenterPanel:newController];
            [sidePanel showCenterPanelAnimated:YES];
        });
        
    }

}

@end
