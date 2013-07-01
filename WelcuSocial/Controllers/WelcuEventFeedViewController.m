//
//  WelcuEventFeedViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventFeedViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <ALRadial/ALRadialMenu.h>

#import "UIImage+MaskedImages.h"
#import "WelcuEventFeedViewCell.h"

@interface WelcuEventFeedViewController () <ALRadialMenuDelegate>

@property (nonatomic,strong) ALRadialMenu *composeMenu;
@property (nonatomic,assign, getter = isComposeMenuVisible) BOOL composeMenuVisible;

@end

@implementation WelcuEventFeedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.composeMenu = [[ALRadialMenu alloc] init];
    self.composeMenu.delegate = self;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WelcuEventFeedViewCell";
    WelcuEventFeedViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];


    cell.postContentLabel.numberOfLines = 0;
    cell.postContentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    [cell.postContentLabel setString:@"Hello #world from @twitter http://welcu.com"];

//    [cell.userPictureView setImageWithURL:[NSURL URLWithString:@""]];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://graph.facebook.com/sagmor/picture"]];

    [cell.userPictureView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        cell.userPictureView.image = [image maskWithImage:[UIImage imageNamed:@"UserPhotoMask"]];
    } failure:nil];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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


# pragma mark ALRadialMenu

- (NSInteger) numberOfItemsInRadialMenu:(ALRadialMenu *)radialMenu
{
    return 3;
}

- (NSInteger) arcSizeForRadialMenu:(ALRadialMenu *)radialMenu
{
    return 90;
}

- (NSInteger) arcRadiusForRadialMenu:(ALRadialMenu *)radialMenu
{
    return 65;
}

- (UIImage *) radialMenu:(ALRadialMenu *)radialMenu imageForIndex:(NSInteger) index
{
    switch (index) {
        case 1:
            return [UIImage imageNamed:@"ComposeImageButtonImage"];
        case 2:
            return [UIImage imageNamed:@"ComposeQuoteButtonImage"];
        case 3:
            return [UIImage imageNamed:@"ComposeButtonImage"];
    }

    return nil;
}

- (void) radialMenu:(ALRadialMenu *)radialMenu didSelectItemAtIndex:(NSInteger) index
{
    [self.composeMenu itemsWillDisapearIntoButton:self.composeButton];
}

- (NSInteger) arcStartForRadialMenu:(ALRadialMenu *)radialMenu
{
    return 95;
}

- (float) buttonSizeForRadialMenu:(ALRadialMenu *)radialMenu
{
    return 40;
}

@end
