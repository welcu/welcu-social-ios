//
//  WelcuAccountTicketsListController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuAccountTicketsListController.h"
#import "WelcuAccount.h"
#import "WelcuTicket.h"
#import "WelcuEventTicketsController.h"
#import "WelcuEventTicketsCell.h"

@interface WelcuAccountTicketsListController ()

@property (nonatomic,strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation WelcuAccountTicketsListController

- (NSFetchedResultsController *)upcomingFetchedResultsController
{
    if (!_upcomingFetchedResultsController) {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"WelcuTicket"];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"event.endsAt >= %@"
                                                    argumentArray:@[[NSDate date]]];
        fetchRequest.sortDescriptors = @[
                                         [NSSortDescriptor sortDescriptorWithKey:@"event.startsAt" ascending:YES]
                                         ];
        fetchRequest.fetchLimit = 20;
        
        _upcomingFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                managedObjectContext:[[WelcuAccount currentAccount] managedObjectContext]
                                                                                  sectionNameKeyPath:@"event.eventID"
                                                                                           cacheName:@"AccountUpcomingEventTickets"];
        _upcomingFetchedResultsController.delegate = self;
    }
    
    return _upcomingFetchedResultsController;
}

- (NSFetchedResultsController *)pastFetchedResultsController
{
    if (!_pastFetchedResultsController) {
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"WelcuTicket"];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"event.endsAt <= %@"
                                                    argumentArray:@[[NSDate date]]];
        fetchRequest.sortDescriptors = @[
                                         [NSSortDescriptor sortDescriptorWithKey:@"event.startsAt" ascending:NO],
                                         [NSSortDescriptor sortDescriptorWithKey:@"event.eventID" ascending:NO]
                                         ];
        fetchRequest.fetchLimit = 20;
        
        _pastFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                            managedObjectContext:[[WelcuAccount currentAccount] managedObjectContext]
                                                                              sectionNameKeyPath:@"event.eventID"
                                                                                       cacheName:@"AccountPastEventTickets"];
        _pastFetchedResultsController.delegate = self;
    }
    
    return _pastFetchedResultsController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WelcuEventTicketsCell" bundle:nil]
         forCellReuseIdentifier:@"WelcuEventTicketsCell"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.currentFetchedResultsController.sections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WelcuEvent *event = [[self.currentFetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row]] event];
    WelcuEventTicketsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WelcuEventTicketsCell" forIndexPath:indexPath];

    cell.event = event;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"WelcuEventTicketsController"
                              sender:[self.tableView cellForRowAtIndexPath:indexPath]];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"WelcuEventTicketsController"]) {
        WelcuEventTicketsController *controller = segue.destinationViewController;
        controller.event = [(WelcuEventTicketsCell *)sender event];
    }
}


@end
