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

@interface WelcuAccountEventsViewController ()

@end

@implementation WelcuAccountEventsViewController

- (NSFetchedResultsController *)upcomingFetchedResultsController
{
    if (!_upcomingFetchedResultsController) {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"WelcuEvent"];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"participating = %@ AND endsAt >= %@"
                                                    argumentArray:@[@(YES), [NSDate date]]];
        fetchRequest.sortDescriptors = @[
                                         [NSSortDescriptor sortDescriptorWithKey:@"startsAt" ascending:YES]
                                         ];
        fetchRequest.fetchLimit = 20;
        
        _upcomingFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                managedObjectContext:[[WelcuAccount currentAccount] managedObjectContext]
                                                                                  sectionNameKeyPath:@"startsAtMonth"
                                                                                           cacheName:@"AccountUpcomingEvents"];
        _upcomingFetchedResultsController.delegate = self;
    }
    
    return _upcomingFetchedResultsController;
}

- (NSFetchedResultsController *)pastFetchedResultsController
{
    if (!_pastFetchedResultsController) {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"WelcuEvent"];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"participating = %@ AND endsAt <= %@"
                                                    argumentArray:@[@(YES), [NSDate date]]];
        fetchRequest.sortDescriptors = @[
                                         [NSSortDescriptor sortDescriptorWithKey:@"startsAt" ascending:NO]
                                         ];
        fetchRequest.fetchLimit = 20;
        
        _pastFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                            managedObjectContext:[[WelcuAccount currentAccount] managedObjectContext]
                                                                              sectionNameKeyPath:@"startsAtMonth"
                                                                                       cacheName:@"AccountPastEvents"];
        _pastFetchedResultsController.delegate = self;
    }
    
    return _pastFetchedResultsController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WelcuEventCell" bundle:nil]
         forCellReuseIdentifier:@"WelcuEventCell"];
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

- (NSDateFormatter *)sectionTitleDateFormatter
{
    static NSDateFormatter *sectionTitleDateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sectionTitleDateFormatter = [[NSDateFormatter alloc] init];
        [sectionTitleDateFormatter setDateFormat:@"MMMM yyyy"];
        [sectionTitleDateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    });
    
    return sectionTitleDateFormatter;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.currentFetchedResultsController.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentFetchedResultsController.sections[section] numberOfObjects];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    WelcuEvent *event = [self.currentFetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    
    return [[self sectionTitleDateFormatter] stringFromDate:event.startsAt];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WelcuEventCell";
    WelcuEventCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    WelcuEvent *event = [self.currentFetchedResultsController objectAtIndexPath:indexPath];
    
    cell.event = event;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"WelcuEventFeedViewController"
                              sender:[self.currentFetchedResultsController objectAtIndexPath:indexPath]];
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

@end
