//
//  WelcuUpcomingAndPastListViewController.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WelcuUpcomingAndPastListViewControllerModeUpcoming = 0,
    WelcuUpcomingAndPastListViewControllerModePast = 1
} WelcuUpcomingAndPastListViewControllerMode;

@interface WelcuUpcomingAndPastListViewController : UIViewController <NSFetchedResultsControllerDelegate,UITableViewDataSource,UITableViewDelegate> {
    NSFetchedResultsController *_pastFetchedResultsController;
    NSFetchedResultsController *_upcomingFetchedResultsController;
}

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,assign) WelcuUpcomingAndPastListViewControllerMode mode;
@property (nonatomic,strong) NSFetchedResultsController *pastFetchedResultsController;
@property (nonatomic,strong) NSFetchedResultsController *upcomingFetchedResultsController;
@property (nonatomic,strong,readonly) NSFetchedResultsController *currentFetchedResultsController;

@end
