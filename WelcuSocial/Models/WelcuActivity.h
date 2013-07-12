//
//  WelcuActivity.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WelcuEvent, WelcuTicket;

@interface WelcuActivity : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *tickets;
@property (nonatomic, retain) WelcuEvent *event;
@end

@interface WelcuActivity (CoreDataGeneratedAccessors)

- (void)addTicketsObject:(WelcuTicket *)value;
- (void)removeTicketsObject:(WelcuTicket *)value;
- (void)addTickets:(NSSet *)values;
- (void)removeTickets:(NSSet *)values;

@end
