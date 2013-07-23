//
//  WelcuPost.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WelcuEvent, WelcuUser;

@interface WelcuPost : NSManagedObject

@property (nonatomic, retain) NSString * subContent;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSString * link;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSNumber *cachedContentHeight;
@property (nonatomic, retain) WelcuEvent *event;
@property (nonatomic, retain) WelcuUser *user;

@end
