//
//  WelcuEventHeaderView.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WelcuEvent;
@class WelcuEventHeaderView;

#define WELCU_EVENT_HEADER_MAX_HEIGHT 250
#define WELCU_EVENT_HEADER_MIN_HEIGHT 74


@protocol WelcuEventHeaderViewDelegate <NSObject>

@optional
- (void)eventHeaderWasTapped:(WelcuEventHeaderView *)headerView;

@end

@interface WelcuEventHeaderView : UIView

+ (WelcuEventHeaderView *)headerView;

@property (nonatomic,weak) id<WelcuEventHeaderViewDelegate> delegate;
@property (nonatomic,strong) WelcuEvent *event;

- (void)setHeight:(CGFloat)height;
- (void)setHeight:(CGFloat)height animated:(BOOL)animated;


@end
