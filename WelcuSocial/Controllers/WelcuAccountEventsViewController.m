//
//  WelcuAccountEventsViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/22/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuAccountEventsViewController.h"
#import "WelcuAccount.h"
#import "WelcuEvent.h"
#import "WelcuEventFeedViewController.h"
#import "WelcuEventCell.h"

@interface WelcuAccountEventsViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation WelcuAccountEventsViewController

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
    fetchRequest.fetchLimit = 20;
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:[[WelcuAccount currentAccount] managedObjectContext]
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:@"MenuEvents"];
    
    self.fetchedResultsController.delegate = self;
    [self refetchData];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WelcuEventCell" bundle:nil]
         forCellReuseIdentifier:@"WelcuEventCell"];
    
    
//    self.fetchedResultsController

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.fetchedResultsController.sections firstObject] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WelcuEventCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    WelcuEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = event.name;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"WelcuEventFeedViewController"
                              sender:[self.fetchedResultsController objectAtIndexPath:indexPath]];
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

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"WelcuEventFeedViewController"]) {
        WelcuEventFeedViewController *controller = segue.destinationViewController;
        controller.event = sender;
    }
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}


@end
