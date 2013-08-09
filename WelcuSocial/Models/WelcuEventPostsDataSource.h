//
//  WelcuEventPostsDataSource.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/9/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuAbstractDataSource.h"

@class WelcuEvent;
@class WelcuPost;

@interface WelcuEventPostsDataSource : WelcuAbstractDataSource

@property (nonatomic,strong) WelcuEvent *event;

- (WelcuPost *)postAtIndex:(NSInteger)index;

@end
