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
#import <ALRadial/ALRadialMenu.h>

#import "WelcuEventPostsController.h"

#import "WelcuEventFeedViewCell.h"
#import "WelcuComposeController.h"

#import "WelcuEventPostCell.h"
#import "WelcuEventPostHeaderView.h"
#import "WelcuEventPostTextCell.h"

@interface WelcuEventFeedViewController () <ALRadialMenuDelegate, WelcuComposeControllerDelegate>

@property (nonatomic,strong) WelcuEventPostsController *postsController;
@property (nonatomic,strong) ALRadialMenu *composeMenu;
@property (nonatomic,assign, getter = isComposeMenuVisible) BOOL composeMenuVisible;

@end

@implementation WelcuEventFeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.postsController = [WelcuEventPostsController controllerWithEvent:self.event];
    
    [self.tableView registerNib:[UINib nibWithNibName:[WelcuEventPostHeaderView className] bundle:nil] forHeaderFooterViewReuseIdentifier:[WelcuEventPostHeaderView className]];

    [self.tableView registerNib:[UINib nibWithNibName:[WelcuEventPostTextCell className] bundle:nil] forCellReuseIdentifier:[WelcuEventPostTextCell className]];
    
    
    [self.tableView setContentInset:UIEdgeInsetsMake(120,0,0,0)];
    
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
    
    self.composeMenu = [[ALRadialMenu alloc] init];
    self.composeMenu.delegate = self;
    
    
//    self.refreshControl = [[UIRefreshControl alloc] init];
//    [self.refreshControl addTarget:self action:@selector(doRefresh:) forControlEvents:UIControlEventValueChanged];
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
    if ([self isComposeMenuVisible]) {
        self.composeMenuVisible = NO;
        [self.composeMenu itemsWillDisapearIntoButton:self.composeButton];
    } else {
        self.composeMenuVisible = YES;
        [self.composeMenu itemsWillAppearFromButton:self.composeButton withFrame:self.composeButton.frame inView:self.view];
    }
}

# pragma mark WelcuComposeControllerDelegate

- (void)composeControllerDidCancel:(WelcuComposeController *)composeController
{
//    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


# pragma mark ALRadialMenu

- (NSInteger) numberOfItemsInRadialMenu:(ALRadialMenu *)radialMenu
{
    return 4;
}

- (NSInteger) arcSizeForRadialMenu:(ALRadialMenu *)radialMenu
{
    return 110;
}

- (NSInteger) arcRadiusForRadialMenu:(ALRadialMenu *)radialMenu
{
    return 70;
}

- (UIImage *) radialMenu:(ALRadialMenu *)radialMenu imageForIndex:(NSInteger) index
{
    switch (index) {
        case 1:
            return [UIImage imageNamed:@"ComposeImageButtonImage"];
        case 2:
            return [UIImage imageNamed:@"ComposeQuoteButtonImage"];
        case 3:
            return [UIImage imageNamed:@"ComposeMessageButtonImage"];
        case 4:
            return [UIImage imageNamed:@"ComposeContactButtonImage"];
    }

    return nil;
}

- (void) radialMenu:(ALRadialMenu *)radialMenu didSelectItemAtIndex:(NSInteger) index
{
    [self.composeMenu itemsWillDisapearIntoButton:self.composeButton];
    
    WelcuComposeController *composeController = nil;
    switch (index) {
        case 1:
            composeController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuComposeImageViewController"];
            break;
        case 2:
            composeController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuComposeMessageViewController"];
            break;
        case 3:
            composeController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuComposeMessageViewController"];
            break;
        case 4:
            composeController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcuComposeMessageViewController"];
            break;

    }
    
    if (composeController) {
        composeController.composeDelegate = self;
//        [self presentPopupViewController:composeController animationType:MJPopupViewAnimationFade];
        
//        NSLog(@"%@", self.mj_popupBackgroundView.subviews);
        
        [self presentViewController:composeController animated:YES completion:^{
        }];
    }
}

- (NSInteger) arcStartForRadialMenu:(ALRadialMenu *)radialMenu
{
    return 91;
}

- (float) buttonSizeForRadialMenu:(ALRadialMenu *)radialMenu
{
    return 40;
}

@end
