//
//  WelcuAbstractDataSource.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/9/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuAbstractDataSource.h"
#import "WelcuAccount.h"

@interface WelcuAbstractDataSource () <NSFetchedResultsControllerDelegate>

@end

@implementation WelcuAbstractDataSource

- (id)init
{
    return [self initWithDelegate:nil];
}

- (id)initWithDelegate:(id<WelcuDataSourceDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.indexPathTransform = WelcuDataSourceIndexIdentityPathTransform;
    }
    return self;
}

- (void)fetchData
{
    [self.fetchedResultsController performSelectorOnMainThread:@selector(performFetch:)
                                                    withObject:nil
                                                 waitUntilDone:YES
                                                         modes:@[ NSRunLoopCommonModes ]];
}

- (NSFetchRequest *)fetchRequest
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@synthesize fetchedResultsController = _fetchedResultsController;

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:self.fetchRequest
                                                                        managedObjectContext:[[WelcuAccount currentAccount] managedObjectContext]
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:self.fetchedResultsControllerCacheName];
        _fetchedResultsController.delegate = self;
    }
    
    return _fetchedResultsController;
}

- (NSString *)fetchedResultsControllerCacheName
{
    return nil;
}

- (NSInteger)numberOfSections
{
    return [self.fetchedResultsController.sections count];
}

- (NSInteger)numberOfObjectsAtSection:(NSInteger)section
{
    return [self.fetchedResultsController.sections[section] numberOfObjects];
}

- (id)objectAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

- (id)objectAtTransformedIndexPath:(NSIndexPath *)indexPath
{
    return [self objectAtIndexPath:self.indexPathTransform(indexPath)];
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.delegate dataSourceDidChangeContent:self];
}

@end
