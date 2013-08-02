//
//  WelcuUpcomingAndPastListViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuUpcomingAndPastListViewController.h"



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
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[
                                                                        NSLocalizedString(@"Upcoming", nil),
                                                                        NSLocalizedString(@"Past", nil)
                                                                        ]];
    [self.segmentedControl addTarget:self action:@selector(segmentedControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.segmentedControl setTintColor:[UIColor blackColor]];
    self.segmentedControl.selectedSegmentIndex = self.mode;
    
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBezeled;
    
    self.tableView.tableHeaderView = self.segmentedControl;
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
