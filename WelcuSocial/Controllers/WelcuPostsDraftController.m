//
//  WelcuDraftPostsController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/19/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuPostsDraftController.h"

@interface WelcuPostsDraftController () <NSFetchedResultsControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation WelcuPostsDraftController

- (id)initWithEvent:(WelcuEvent *)event
{
    self = [super init];
    if (self) {
        self.event = event;
        
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"WelcuPostDraft"];
        request.predicate = [NSPredicate predicateWithFormat:@"event = %@ AND published = %@" argumentArray:@[self.event, @(NO)]];
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                            managedObjectContext:self.event.managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:nil];
        self.fetchedResultsController.delegate = self;
    }
    
    return self;
}

+ (WelcuPostsDraftController *)draftPostsControllerForEvent:(WelcuEvent *)event
{
    WelcuPostsDraftController *controller = [[WelcuPostsDraftController alloc] init];
    controller.event = event;
    
    
    return controller;
}

- (void)addToView:(UIView *)view
{
}

# pragma mark - NSFetchedResultsControllerDelegate
# pragma mark - UITableViewDataSource
# pragma mark - UITableViewDelegate

@end
