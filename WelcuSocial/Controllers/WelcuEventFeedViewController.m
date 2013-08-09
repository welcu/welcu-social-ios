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
#import <FontasticIcons/FontasticIcons.h>

#import "WelcuAccount.h"
#import "WelcuPost.h"

#import "WelcuEventFeedViewCell.h"
#import "WelcuComposeController.h"
#import "WelcuComposePhotoController.h"

#import "WelcuEventPostsDataSource.h"

#import "WelcuEventPostCell.h"
#import "WelcuEventPostHeaderView.h"
#import "WelcuEventPostTextCell.h"
#import "WelcuEventPostPhotoCell.h"
#import "WelcuEventHeaderView.h"
#import "WelcuEventTicketsController.h"

NSString const * kWelcuEventPostHeaderViewClassName = @"WelcuEventPostHeaderView";
NSString const * kWelcuEventPostTextCellClassName = @"WelcuEventPostTextCell";

@interface WelcuEventFeedViewController () <WelcuDataSourceDelegate>

@property (nonatomic,strong) NSTimer *refetchTimer;

@property (nonatomic,assign, getter = isComposeMenuVisible) BOOL composeMenuVisible;
@property (nonatomic,strong) WelcuEventHeaderView *headerView;
@property (nonatomic,strong)  UINavigationBar *navigationBar;

@property (nonatomic,strong) WelcuEventPostsDataSource *postsDataSource;

@end

@implementation WelcuEventFeedViewController

- (void)viewDidLoad
{
    NSParameterAssert(self.event);
    [self.event accessed];

    [super viewDidLoad];
    
    if ([self.event.tickets count]) {
        self.navigationItem.rightBarButtonItem.image = [[FIFontAwesomeIcon ticketIcon] imageWithBounds:CGRectMake(0, 0, 22, 22) color:[UIColor blackColor]];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    self.postsDataSource = [[WelcuEventPostsDataSource alloc] initWithDelegate:self];
    self.postsDataSource.event = self.event;
    self.postsDataSource.indexPathTransform = ^(NSIndexPath *indexPath){
        return [NSIndexPath indexPathForRow:indexPath.section inSection:0];
    };
    [self.postsDataSource fetchData];
    
    [self.tableView registerNib:[UINib nibWithNibName:(NSString *)kWelcuEventPostHeaderViewClassName
                                               bundle:nil] forHeaderFooterViewReuseIdentifier:(NSString *)kWelcuEventPostHeaderViewClassName];

    [self.tableView registerNib:[UINib nibWithNibName:(NSString *)kWelcuEventPostTextCellClassName
                                               bundle:nil] forCellReuseIdentifier:(NSString *)kWelcuEventPostTextCellClassName];

    [self.tableView registerNib:[UINib nibWithNibName:@"WelcuEventPostPhotoCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"WelcuEventPostPhotoCell"];

    [self.tableView setTableHeaderView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, WELCU_EVENT_HEADER_DEFAULT_HEIGHT-WELCU_EVENT_HEADER_MIN_HEIGHT)]];

    
    self.headerView = [WelcuEventHeaderView headerView];
    self.headerView.frame = CGRectMake(0, -WELCU_EVENT_HEADER_MIN_HEIGHT, self.view.bounds.size.width, WELCU_EVENT_HEADER_DEFAULT_HEIGHT);
    self.headerView.event = self.event;
    
    // Hack to get the table view scroller gesture
    for (id recognizer in self.tableView.gestureRecognizers) {
        if ([recognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
            self.headerView.gestureRecognizers = @[ recognizer ];
        }
    }

    [self.view addSubview:self.headerView];
}

- (void)viewWillAppear:(BOOL)animated
{
    DDLogInfo(@"viewWillAppear:");
    [self scrollViewDidScroll:self.tableView];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
//    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
//    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ClearPixel"]
                                                  forBarMetrics:UIBarMetricsDefault];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self scrollViewDidScroll:self.tableView];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ClearPixel"]
                                                  forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"ClearPixel"]
//                                                  forBarMetrics:UIBarMetricsDefault];
    
    self.refetchTimer = [NSTimer scheduledTimerWithTimeInterval:10
                                                         target:self.postsDataSource
                                                       selector:@selector(fetchData)
                                                       userInfo:nil
                                                        repeats:YES];
}

- (void)navigationControllerBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidDisappear:(BOOL)animated
{
    DDLogInfo(@"viewDidDisappear:");

    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil
                                                  forBarMetrics:UIBarMetricsDefault];
    
    [self.refetchTimer invalidate];
    self.refetchTimer = nil;
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
    return [self.postsDataSource numberOfObjectsAtSection:0];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    WelcuPost *post = [self.postsDataSource postAtIndex:section];
    
    if (post.photo) {
        return 2;
    } else {
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [WelcuEventPostHeaderView rowHeightForPost:[self.postsDataSource postAtIndex:section]];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    WelcuEventPostHeaderView *header = (WelcuEventPostHeaderView *)[self.tableView dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)kWelcuEventPostHeaderViewClassName];
    
    header.post = [self.postsDataSource postAtIndex:section];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WelcuPost *post = [self.postsDataSource postAtIndex:indexPath.section];
    
    if (post.photo && indexPath.row == 0) {
        return [WelcuEventPostPhotoCell rowHeightForPost:post];
    } else {
        return [WelcuEventPostTextCell rowHeightForPost:post];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WelcuPost *post = [self.postsDataSource postAtIndex:indexPath.section];
    
    UITableViewCell <WelcuEventPostCell> *cell = nil;
    
    if (post.photo && indexPath.row == 0) {
        cell = [self.tableView dequeueReusableCellWithIdentifier:@"WelcuEventPostPhotoCell" forIndexPath:indexPath];
    } else {
        cell = [self.tableView dequeueReusableCellWithIdentifier:(NSString *)kWelcuEventPostTextCellClassName forIndexPath:indexPath];
    }

    cell.post = post;
    
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

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

# pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.headerView setHeight:(WELCU_EVENT_HEADER_DEFAULT_HEIGHT - scrollView.contentOffset.y)];
}


# pragma mark WelcuComposeControllerDelegate

- (void)composeControllerDidCancel:(WelcuComposeController *)composeController
{
//    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - WelcuDataSourceDelegate

- (void)dataSourceDidChangeContent:(WelcuAbstractDataSource *)dataSource {
    [self.tableView reloadData];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"WelcuEventTicketsController"]) {
        WelcuEventTicketsController *controller = segue.destinationViewController;
        controller.event = self.event;
    }
}

@end
