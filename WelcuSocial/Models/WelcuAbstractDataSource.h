//
//  WelcuAbstractDataSource.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/9/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <CoreData/CoreData.h>

typedef NSIndexPath*(^WelcuDataSourceIndexPathTransform)(NSIndexPath *);

static const WelcuDataSourceIndexPathTransform WelcuDataSourceIndexIdentityPathTransform = ^(NSIndexPath *indexPath){
    return indexPath;
};

@class WelcuAbstractDataSource;

@protocol WelcuDataSourceDelegate <NSObject>

- (void)dataSourceDidChangeContent:(WelcuAbstractDataSource *)dataSource;

@end

@interface WelcuAbstractDataSource : NSObject

@property (nonatomic,weak) id<WelcuDataSourceDelegate> delegate;
@property (nonatomic,readonly) NSFetchRequest *fetchRequest;
@property (nonatomic,readonly) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic,readonly) NSString *fetchedResultsControllerCacheName;
@property (nonatomic,strong) WelcuDataSourceIndexPathTransform indexPathTransform;


- (id)initWithDelegate:(id<WelcuDataSourceDelegate>)delegate;

- (void)fetchData;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfObjectsAtSection:(NSInteger)section;
- (id)objectAtIndexPath:(NSIndexPath *)indexPath;

/**
 Convinience method that transforms the indexpath using indexPathTransform before retreiving the object
 
 @param indexPath The raw index path
 @return the object at the transformed indexPath
 */
- (id)objectAtTransformedIndexPath:(NSIndexPath *)indexPath;

@end
