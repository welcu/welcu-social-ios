//
//  WelcuEventPostsController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventPostsController.h"

@interface WelcuEventPostsController ()

@end


@implementation WelcuEventPostsController

- (id)initWithEvent:(WelcuEvent *)event
{
    self = [super init];
    if (self) {
        self.event = event;
    }
    return self;
}

+ (WelcuEventPostsController *)controllerWithEvent:(WelcuEvent *)event
{
    return [[WelcuEventPostsController alloc] initWithEvent:event];
}

- (NSUInteger)postsCount
{
    return 7;
}

- (WelcuPost *)postAtIndex:(NSUInteger)index
{
    return nil;
}

- (void)applyFetchedPosts
{
    
}



@end
