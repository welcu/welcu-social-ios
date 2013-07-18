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
#import "WelcuEventCell.h"

typedef enum {
    WelcuMenuViewControllerUnknownRowType = 0,

    WelcuMenuViewControllerUserProfileRowType,
    WelcuMenuViewControllerUserTicketsRowType,
    WelcuMenuViewControllerDiscoverEventsRowType,
    WelcuMenuViewControllerEventRowType,
    WelcuMenuViewControllerUserEventsRowType
    } WelcuMenuViewControllerRowTypes;

@interface WelcuMenuViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic,strong) NSFetchedResultsController *fetchedResultsController;

- (WelcuMenuViewControllerRowTypes)rowTypeForIndexPath:(NSIndexPath *)indexPath;
- (void)refetchData;

@end

@implementation WelcuMenuViewController

- (void)refetchData {
    [self.fetchedResultsController performSelectorOnMainThread:@selector(performFetch:)
                                                    withObject:nil
                                                 waitUntilDone:YES
                                                         modes:@[ NSRunLoopCommonModes ]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"WelcuEvent"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"participating = %@ AND endsAt > %@" argumentArray:@[@(YES), [NSDate date]]];
    fetchRequest.sortDescriptors = @[
                                     [NSSortDescriptor sortDescriptorWithKey:@"accessedAt" ascending:NO]
                                     ];
    fetchRequest.fetchLimit = 9;
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:[[WelcuAccount currentAccount] managedObjectContext]
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:@"MenuEvents"];
    
    self.fetchedResultsController.delegate = self;
    [self refetchData];

    [self.tableView registerNib:[UINib nibWithNibName:[WelcuMenuUserProfileCell className] bundle:nil]
         forCellReuseIdentifier:[WelcuMenuUserProfileCell className]];

    [self.tableView registerNib:[UINib nibWithNibName:[WelcuEventCell className] bundle:nil]
         forCellReuseIdentifier:[WelcuEventCell className]];


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    CGRect rect = self.view.frame;
    rect.origin.x = 10;
    rect.origin.y = 20;
    rect.size.height = rect.size.height - 10 - 20;
    rect.size.width = rect.size.width - 70;
    self.view.frame = rect;

    rect.origin.x = 0;
    rect.origin.y = 0;
    self.view.bounds = rect;
}

- (WelcuMenuViewControllerRowTypes)rowTypeForIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return WelcuMenuViewControllerUserProfileRowType;
        case 1:
            switch (indexPath.row) {
                case 0:
                    return WelcuMenuViewControllerUserTicketsRowType;
                case 1:
                    return WelcuMenuViewControllerDiscoverEventsRowType;
            }
            break;
        case 2:
            return WelcuMenuViewControllerEventRowType;
        case 3:
            return WelcuMenuViewControllerUserEventsRowType;
    }

    return WelcuMenuViewControllerUnknownRowType;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 2;
        case 2:
            return [self.fetchedResultsController.sections[0] numberOfObjects];
        case 3:
            return 1;
    }

    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if ([self rowTypeForIndexPath:indexPath] == WelcuMenuViewControllerUserProfileRowType) {
        WelcuMenuUserProfileCell *cell =
        [tableView dequeueReusableCellWithIdentifier:[WelcuMenuUserProfileCell className]
                                        forIndexPath:indexPath];
        return cell;
    }
    
    WelcuEvent *event = nil;

    switch ([self rowTypeForIndexPath:indexPath]) {
        case WelcuMenuViewControllerUserProfileRowType:
            cell = [tableView dequeueReusableCellWithIdentifier:[WelcuMenuUserProfileCell className]
                                                   forIndexPath:indexPath];
            break;

        case WelcuMenuViewControllerUserTicketsRowType:
            cell = [tableView dequeueReusableCellWithIdentifier:@"WelcuMenuUserTicketsCell"
                                                   forIndexPath:indexPath];
            break;
        case WelcuMenuViewControllerDiscoverEventsRowType:
            cell = [tableView dequeueReusableCellWithIdentifier:@"WelcuMenuDiscoverCell"
                                                   forIndexPath:indexPath];
            break;
        case WelcuMenuViewControllerEventRowType:
            cell = [tableView dequeueReusableCellWithIdentifier:[WelcuEventCell className]
                                                   forIndexPath:indexPath];
            event = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];

            cell.textLabel.text = event.name;
            cell.detailTextLabel.text = @"30 de Junio 2013";
            break;
        case WelcuMenuViewControllerUserEventsRowType:
            cell = [tableView dequeueReusableCellWithIdentifier:@"WelcuMenuUserEventsCell"
                                                   forIndexPath:indexPath];
            break;
        default:
            break;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return nil;
        case 1:
            return @" ";
        case 2:
            return @"My events";
        case 3:
            return nil;
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *newController = nil;

    switch ([self rowTypeForIndexPath:indexPath]) {
        case WelcuMenuViewControllerUserProfileRowType:
            [WelcuAccount logOut];
            break;

        case WelcuMenuViewControllerUserTicketsRowType:
            newController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuUserTicketsNavigationController"];
            break;
        case WelcuMenuViewControllerDiscoverEventsRowType:
            newController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuDiscoverNavigationController"];
            break;
        case WelcuMenuViewControllerEventRowType:
            newController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuEventFeedNavigationController"];
            break;
        case WelcuMenuViewControllerUserEventsRowType:
            newController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuUserEventsNavigationController"];
            break;
        default:
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

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
}

@end
