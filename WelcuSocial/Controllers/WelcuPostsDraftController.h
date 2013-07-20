//
//  WelcuDraftPostsController.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/19/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WelcuEvent.h"

@interface WelcuPostsDraftController : NSObject

@property (strong, nonatomic) WelcuEvent *event;

+ (WelcuPostsDraftController *)draftPostsControllerForEvent:(WelcuEvent *)event;
- (void)addToView:(UIView *)view;


@end
