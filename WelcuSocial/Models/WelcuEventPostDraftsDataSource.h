//
//  WelcuPostDraftsDataSource.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/9/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuAbstractDataSource.h"

@class WelcuEvent;
@class WelcuPostDraft;

@interface WelcuEventPostDraftsDataSource : WelcuAbstractDataSource

@property (nonatomic,strong) WelcuEvent *event;

- (WelcuPostDraft *)postDraftAtIndex:(NSInteger)index;

@end
