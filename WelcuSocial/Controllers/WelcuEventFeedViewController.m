//
//  WelcuEventFeedViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventFeedViewController.h"
#import <MJPopupViewController/UIViewController+MJPopupViewController.h>
#import <MJPopupViewController/MJPopupBackgroundView.h>

#import <PCStackMenu/PCStackMenu.h>

#import "WelcuEventPostsController.h"

#import "WelcuEventFeedViewCell.h"
#import "WelcuComposeController.h"

#import "WelcuEventPostCell.h"
#import "WelcuEventPostHeaderView.h"
#import "WelcuEventPostTextCell.h"
#import "WelcuEventHeaderView.h"

@interface WelcuEventFeedViewController ()

@property (nonatomic,strong) WelcuEventPostsController *postsController;
@property (nonatomic,assign, getter = isComposeMenuVisible) BOOL composeMenuVisible;

@property (nonatomic,strong) WelcuEventHeaderView *headerView;

@end

@implementation WelcuEventFeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.postsController = [WelcuEventPostsController controllerWithEvent:self.event];
    
    [self.tableView registerNib:[UINib nibWithNibName:[WelcuEventPostHeaderView className] bundle:nil] forHeaderFooterViewReuseIdentifier:[WelcuEventPostHeaderView className]];

    [self.tableView registerNib:[UINib nibWithNibName:[WelcuEventPostTextCell className] bundle:nil] forCellReuseIdentifier:[WelcuEventPostTextCell className]];
    
    self.headerView = [WelcuEventHeaderView headerView];
    self.headerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, WELCU_EVENT_HEADER_MAX_HEIGHT);
    self.headerView.event = self.event;
    [self.view addSubview:self.headerView];

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.postsController postsCount];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [WelcuEventPostHeaderView rowHeightForPost:[self.postsController postAtIndex:section]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WelcuEventPostHeaderView *header = (WelcuEventPostHeaderView *)[self.tableView dequeueReusableHeaderFooterViewWithIdentifier:[WelcuEventPostHeaderView className]];
    
    header.post = [self.postsController postAtIndex:section];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WelcuEventPostTextCell rowHeightForPost:[self.postsController postAtIndex:indexPath.section]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell <WelcuEventPostCell> *cell = [self.tableView dequeueReusableCellWithIdentifier:[WelcuEventPostTextCell className] forIndexPath:indexPath];
    
    cell.post = [self.postsController postAtIndex:indexPath.section];
    
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
    

    
    [PCStackMenu showStackMenuWithTitles:@[@" ", @" ", @" ", @" "]
                              withImages:@[
                                           [UIImage imageNamed:@"ComposeImageButtonImage"],
                                           [UIImage imageNamed:@"ComposeQuoteButtonImage"],
                                           [UIImage imageNamed:@"ComposeMessageButtonImage"],
                                           [UIImage imageNamed:@"ComposeContactButtonImage"]
                                           ]
                            atStartPoint:CGPointMake(button.frame.origin.x + button.frame.size.width, button.frame.origin.y)
                                  inView:self.view
                              itemHeight:40
                           menuDirection:PCStackMenuDirectionClockWiseUp
                            onSelectMenu:^(NSInteger selectedMenuIndex) {
                                NSLog(@"menu index : %d", selectedMenuIndex);
                                WelcuComposeController *composeController = [WelcuComposeController composeController];
                                composeController.event = self.event;
                                composeController.postType = WelcuComposePlainPostType;
                                [composeController presentComposeController];
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
}


# pragma mark WelcuComposeControllerDelegate

- (void)composeControllerDidCancel:(WelcuComposeController *)composeController
{
//    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
