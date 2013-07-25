//
//  WelcuEvent.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WelcuActivity, WelcuPost, WelcuTicket;

@interface WelcuEvent : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *headerPhoto;
@property (nonatomic, retain) NSNumber *eventID;
@property (nonatomic, retain) NSDate *startsAt;
@property (nonatomic, retain) NSDate *endsAt;
@property (nonatomic, retain) NSDate *accessedAt;
@property (nonatomic, retain) NSString *venueName;
@property (nonatomic, retain) NSString *venueAddress;

@property (nonatomic, retain) NSSet *posts;
@property (nonatomic, retain) NSSet *tickets;
@property (nonatomic, retain) NSSet *activities;

@property (nonatomic, readonly) NSURL *headerPhotoURL;

- (void)accessed;

- (NSString *)fromDateToDateString;

@end

@interface WelcuEvent (CoreDataGeneratedAccessors)

- (void)addPostsObject:(WelcuPost *)value;
- (void)removePostsObject:(WelcuPost *)value;
- (void)addPosts:(NSSet *)values;
- (void)removePosts:(NSSet *)values;

- (void)addTicketsObject:(WelcuTicket *)value;
- (void)removeTicketsObject:(WelcuTicket *)value;
- (void)addTickets:(NSSet *)values;
- (void)removeTickets:(NSSet *)values;

- (void)addActivitiesObject:(WelcuActivity *)value;
- (void)removeActivitiesObject:(WelcuActivity *)value;
- (void)addActivities:(NSSet *)values;
- (void)removeActivities:(NSSet *)values;

@end
