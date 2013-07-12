//
//  WelcuTicket.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WelcuActivity, WelcuEvent;

@interface WelcuTicket : NSManagedObject

@property (nonatomic, retain) NSString * code;
@property (nonatomic, retain) NSDate * checkedAt;
@property (nonatomic, retain) WelcuEvent *event;
@property (nonatomic, retain) WelcuActivity *activity;

@end
