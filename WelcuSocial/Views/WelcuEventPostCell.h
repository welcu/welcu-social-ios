//
//  WelcuFeedPostCell.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString const *kWelcuEventPostHeaderViewClassName;
extern NSString const *kWelcuEventPostTextCellClassName;
extern NSString const *kWelcuEventPostTextCellClassName;
extern NSString const *kWelcuEventPostQuoteCellClassName;

@class WelcuPost;

@protocol WelcuEventPostCell <NSObject>

@required

@property (nonatomic, strong) WelcuPost *post;

+ (CGFloat)rowHeightForPost:(WelcuPost *)post;

@end
