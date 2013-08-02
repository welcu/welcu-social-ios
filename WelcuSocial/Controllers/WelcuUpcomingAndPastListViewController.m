//
//  WelcuUpcomingAndPastListViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuUpcomingAndPastListViewController.h"

#import <SDSegmentedControl/SDSegmentedControl.h>



@interface WelcuUpcomingAndPastListViewController ()

@property (nonatomic,strong) UISegmentedControl *segmentedControl;


@end

@implementation WelcuUpcomingAndPastListViewController

@synthesize mode = _mode;
@synthesize pastFetchedResultsController = _pastFetchedResultsController;
@synthesize upcomingFetchedResultsController = _upcomingFetchedResultsController;

- (void)setMode:(WelcuUpcomingAndPastListViewControllerMode)mode
{
    _mode = mode;
    [self refetchData];
    [self.tableView reloadData];
}

- (NSFetchedResultsController *)currentFetchedResultsController
{
    switch (self.mode) {
        case WelcuUpcomingAndPastListViewControllerModeUpcoming:
            return self.upcomingFetchedResultsController;
        case WelcuUpcomingAndPastListViewControllerModePast:
            return self.pastFetchedResultsController;
    }
}

- (void)refetchData {
    [self.currentFetchedResultsController performSelectorOnMainThread:@selector(performFetch:)
                                                           withObject:nil
                                                        waitUntilDone:YES
                                                                modes:@[ NSRunLoopCommonModes ]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refetchData];
    
    self.segmentedControl = [[SDSegmentedControl alloc] initWithItems:@[
                                                                        NSLocalizedString(@"Upcoming", nil),
                                                                        NSLocalizedString(@"Past", nil)
                                                                        ]];
    
    [self.segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl.selectedSegmentIndex = self.mode;
    self.segmentedControl.frame = CGRectMake(0, 0, self.view.frame.size.width, 43);
    [self.view addSubview:self.segmentedControl];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 43, self.view.frame.size.width, self.view.frame.size.height-43)
                                                  style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
}

- (void)segmentedControlValueChanged:(id)sender
{
    self.mode = self.segmentedControl.selectedSegmentIndex;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Release the unused NSFetchedResultsController
    switch (self.mode) {
        case WelcuUpcomingAndPastListViewControllerModeUpcoming:
            self.pastFetchedResultsController = nil;
            break;
        case WelcuUpcomingAndPastListViewControllerModePast:
            self.upcomingFetchedResultsController = nil;
            break;
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    if (controller == self.currentFetchedResultsController) {
        [self.tableView reloadData];
    }
}


@end
