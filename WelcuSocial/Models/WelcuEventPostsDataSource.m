//
//  WelcuEventPostsDataSource.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/9/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventPostsDataSource.h"

@implementation WelcuEventPostsDataSource

@synthesize fetchRequest = _fetchRequest;

- (NSFetchRequest *)fetchRequest
{
    if (!_fetchRequest) {
        _fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"WelcuPost"];
        _fetchRequest.predicate = [NSPredicate predicateWithFormat:@"event = %@"
                                                     argumentArray:@[self.event]];
        _fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"createdAt"
                                                                                               ascending:NO]];
        _fetchRequest.fetchLimit = 50;
    }
    
    return _fetchRequest;
}

- (WelcuPost *)postAtIndex:(NSInteger)index
{
    return [self objectAtIndexPath:[NSIndexPath indexPathForRow:index
                                                      inSection:0]];
}

@end
