//
//  WelcuEventFeedViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventFeedViewController.h"
#import <JASidePanels/UIViewController+JASidePanel.h>
#import <JASidePanels/JASidePanelController.h>
#import <MJPopupViewController/UIViewController+MJPopupViewController.h>
#import <MJPopupViewController/MJPopupBackgroundView.h>

#import <PCStackMenu/PCStackMenu.h>

#import "WelcuAccount.h"

#import "WelcuEventFeedViewCell.h"
#import "WelcuComposeController.h"
#import "WelcuComposePhotoController.h"

#import "WelcuEventPostCell.h"
#import "WelcuEventPostHeaderView.h"
#import "WelcuEventPostTextCell.h"
#import "WelcuEventHeaderView.h"

NSString const * kWelcuEventPostHeaderViewClassName = @"WelcuEventPostHeaderView";
NSString const * kWelcuEventPostTextCellClassName = @"WelcuEventPostTextCell";

@interface WelcuEventFeedViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic,assign, getter = isComposeMenuVisible) BOOL composeMenuVisible;
@property (nonatomic,strong) WelcuEventHeaderView *headerView;
@property (nonatomic,strong)  UINavigationBar *navigationBar;

@property (nonatomic,strong) NSFetchedResultsController *fetchedResultsController;

- (WelcuPost *)postAtIndex:(NSInteger)index;
- (void)refetchData;

@end

@implementation WelcuEventFeedViewController

- (void)refetchData {
    [self.fetchedResultsController performSelectorOnMainThread:@selector(performFetch:)
                                                    withObject:nil
                                                 waitUntilDone:YES
                                                         modes:@[ NSRunLoopCommonModes ]];
}

- (WelcuPost *)postAtIndex:(NSInteger)index
{
    return [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"WelcuPost"];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"event.eventID = %@" argumentArray:@[@1]];
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"postID" ascending:NO]];
    fetchRequest.fetchLimit = 50;
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:[[WelcuAccount currentAccount] managedObjectContext]
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:@"EventStream"];
    self.fetchedResultsController.delegate = self;
    [self refetchData];
    
    [self.tableView registerNib:[UINib nibWithNibName:(NSString *)kWelcuEventPostHeaderViewClassName
                                               bundle:nil] forHeaderFooterViewReuseIdentifier:(NSString *)kWelcuEventPostHeaderViewClassName];

    [self.tableView registerNib:[UINib nibWithNibName:(NSString *)kWelcuEventPostTextCellClassName
                                               bundle:nil] forCellReuseIdentifier:(NSString *)kWelcuEventPostTextCellClassName];
    
    self.navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 15, self.view.bounds.size.width, 44)];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"ClearPixel"]
                             forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.navigationBar];

    self.headerView = [WelcuEventHeaderView headerView];
    self.headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, WELCU_EVENT_HEADER_MAX_HEIGHT);
    self.headerView.event = self.event;

    [self.view insertSubview:self.headerView belowSubview:self.navigationBar];

//    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:self.headerView.frame]];

    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, WELCU_EVENT_HEADER_MAX_HEIGHT-WELCU_EVENT_HEADER_MIN_HEIGHT)]];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    
//    self.refreshControl = [[UIRefreshControl alloc] init];
//    [self.refreshControl addTarget:self action:@selector(doRefresh:) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self scrollViewDidScroll:self.tableView];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewDidAppear:(BOOL)animated
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (![self.navigationBar.items count]) {
            UINavigationItem *nav = [[UINavigationItem alloc] initWithTitle:@"Event Feed"];
            if (self.navigationItem.leftBarButtonItem) {
                nav.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:self.navigationItem.leftBarButtonItem.image
                                                                         style:self.navigationItem.leftBarButtonItem.style
                                                                        target:self.navigationItem.leftBarButtonItem.target
                                                                        action:self.navigationItem.leftBarButtonItem.action];
            } else {
                nav.leftBarButtonItem = [self.sidePanelController leftButtonForCenterPanel];
            }
            
            nav.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:self.navigationItem.rightBarButtonItem.image
                                                                      style:self.navigationItem.rightBarButtonItem.style
                                                                     target:self.navigationItem.rightBarButtonItem.target
                                                                     action:self.navigationItem.rightBarButtonItem.action];
            
            self.navigationBar.items = @[nav];
        }
    });
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
//    [self.navigationController.navigationBar setBackgroundImage:nil
//                                                  forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[[self.fetchedResultsController sections] firstObject] numberOfObjects];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [WelcuEventPostHeaderView rowHeightForPost:[self postAtIndex:section]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WelcuEventPostHeaderView *header = (WelcuEventPostHeaderView *)[self.tableView dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)kWelcuEventPostHeaderViewClassName];
    
    header.post = [self postAtIndex:section];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WelcuEventPostTextCell rowHeightForPost:[self postAtIndex:indexPath.section]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell <WelcuEventPostCell> *cell = [self.tableView dequeueReusableCellWithIdentifier:(NSString *)kWelcuEventPostTextCellClassName forIndexPath:indexPath];
    
    cell.post = [self postAtIndex:indexPath.section];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (IBAction)startComposeAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    

    
    [PCStackMenu showStackMenuWithTitles:@[@" ", @" "]
                              withImages:@[
                                           [UIImage imageNamed:@"ComposeImageButtonImage"],
                                           [UIImage imageNamed:@"ComposeMessageButtonImage"]
                                           ]
                            atStartPoint:CGPointMake(button.frame.origin.x + button.frame.size.width, button.frame.origin.y)
                                  inView:self.view
                              itemHeight:40
                           menuDirection:PCStackMenuDirectionClockWiseUp
                            onSelectMenu:^(NSInteger selectedMenuIndex) {
                                if (selectedMenuIndex == 0) {
                                    WelcuComposePhotoController *composeController = [[WelcuComposePhotoController alloc] init];
                                    
                                    composeController.event = self.event;
                                    [composeController presentComposeControllerOn:self];
                                } else if (selectedMenuIndex == 1) {
                                    WelcuComposeController *composeController = [WelcuComposeController composeController];
                                    composeController.event = self.event;
                                    composeController.postType = WelcuComposePlainPostType;
                                    [composeController presentComposeController];
                                }
                            }];
    
//    if ([self isComposeMenuVisible]) {
//        self.composeMenuVisible = NO;
//        [self.composeMenu itemsWillDisapearIntoButton:self.composeButton];
//    } else {
//        self.composeMenuVisible = YES;
//        [self.composeMenu itemsWillAppearFromButton:self.composeButton withFrame:self.composeButton.frame inView:self.view];
//    }
}

# pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.headerView setHeight:(WELCU_EVENT_HEADER_MAX_HEIGHT - scrollView.contentOffset.y)];
    
    // TODO: Hide navigation Bar
}


# pragma mark WelcuComposeControllerDelegate

- (void)composeControllerDidCancel:(WelcuComposeController *)composeController
{
//    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView reloadData];
}

@end
