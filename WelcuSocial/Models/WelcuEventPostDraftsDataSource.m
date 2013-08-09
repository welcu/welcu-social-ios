//
//  WelcuPostDraftsDataSource.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/9/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventPostDraftsDataSource.h"

@implementation WelcuEventPostDraftsDataSource

@synthesize fetchRequest = _fetchRequest;

- (NSFetchRequest *)fetchRequest
{
    if (!_fetchRequest) {
        _fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"WelcuPostDraft"];
        _fetchRequest.predicate = [NSPredicate predicateWithFormat:@"event = %@ AND published = %@"
                                                     argumentArray:@[self.event, @(NO)]];
        _fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"createdAt"
                                                                                               ascending:YES]];
        _fetchRequest.fetchLimit = 50;
    }
    
    return _fetchRequest;
}

- (WelcuPostDraft *)postDraftAtIndex:(NSInteger)index
{
    return [self objectAtIndexPath:[NSIndexPath indexPathForRow:index
                                                      inSection:0]];
}

@end
