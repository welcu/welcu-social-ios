//
//  WelcuDiscoverEventsViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/26/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuDiscoverEventsViewController.h"

#import <CHTCollectionViewWaterfallLayout/CHTCollectionViewWaterfallLayout.h>

#import "WelcuDiscoverEventCell.h"
#import "WelcuAccount.h"

@interface WelcuDiscoverEventsViewController () <NSFetchedResultsControllerDelegate,CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic,strong) NSFetchedResultsController *fetchedResultsController;

@end

@implementation WelcuDiscoverEventsViewController

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
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"endsAt >= %@"
                                                argumentArray:@[[NSDate date]]];
    fetchRequest.sortDescriptors = @[
                                     [NSSortDescriptor sortDescriptorWithKey:@"startsAt" ascending:YES]
                                     ];
    fetchRequest.fetchLimit = 20;
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                            managedObjectContext:[[WelcuAccount currentAccount] managedObjectContext]
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:@"DiscoverEvents"];
    self.fetchedResultsController.delegate = self;
    [self refetchData];
    
    CHTCollectionViewWaterfallLayout *waterfallLayout = (CHTCollectionViewWaterfallLayout *)self.collectionViewLayout;
    waterfallLayout.columnCount = 2;
    waterfallLayout.itemWidth = 145;
    waterfallLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [[self.fetchedResultsController.sections firstObject] numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WelcuEvent *event = [self.fetchedResultsController objectAtIndexPath:indexPath];
    WelcuDiscoverEventCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"WelcuDiscoverEventCell"
                                                                                  forIndexPath:indexPath];
    
    cell.event = event;
    
    return cell;
}


//#pragma mark - UICollectionViewDelegateFlowLayout
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [WelcuDiscoverEventCell sizeForEvent:[self.fetchedResultsController objectAtIndexPath:indexPath]];
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(10, 10, 10, 10);
//}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(CHTCollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [WelcuDiscoverEventCell heightForEvent:[self.fetchedResultsController objectAtIndexPath:indexPath]];
}

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.collectionView reloadData];
}


@end
