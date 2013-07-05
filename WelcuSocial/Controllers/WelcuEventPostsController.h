//
//  WelcuEventPostsController.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WelcuEvent;
@class WelcuPost;
@class WelcuEventPostsController;

@protocol WelcuEventPostsControllerDelegate <NSObject>

- (void)eventPostsControllerFetchedNewPosts:(WelcuEventPostsController *)postsController;

@end


@interface WelcuEventPostsController : NSObject

@property (strong) WelcuEvent *event;
@property (weak) id <WelcuEventPostsControllerDelegate> delegate;

- (id)initWithEvent:(WelcuEvent *)event;
+ (WelcuEventPostsController *)controllerWithEvent:(WelcuEvent *)event;

- (NSUInteger)postsCount;
- (WelcuPost *)postAtIndex:(NSUInteger)index;

- (void)applyFetchedPosts;

@end
