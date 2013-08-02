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

/**
 An event on Welcu Social database
 */
@interface WelcuEvent : NSManagedObject

#pragma mark - Base Attributes

/** The event name */
@property (nonatomic, strong) NSString *name;

/** The event UUID identifier */
@property (nonatomic, strong) NSString *eventID;

@property (nonatomic, strong) NSString *eventURLString;
@property (nonatomic, readonly) NSURL *eventURL;

/** The event start date */
@property (nonatomic, strong) NSDate *startsAt;

/** The event end date */
@property (nonatomic, strong) NSDate *endsAt;

@property (nonatomic, readonly) NSString *formattedDateRange;

/** The event last access date, used to get the last used event on app launch */
@property (nonatomic, strong) NSDate *accessedAt;

@property (nonatomic, strong) NSString *venueName;
@property (nonatomic, strong) NSString *venueAddress;

@property (nonatomic, strong) NSString *basePriceCurrency;
@property (nonatomic, strong) NSNumber *basePriceValue;
@property (nonatomic, readonly) NSString *formattedBasePrice;

#pragma mark - Event images

@property (nonatomic, strong) NSString *headerPhoto;
@property (nonatomic, readonly) NSURL *headerPhotoURL;

@property (nonatomic, strong) NSString *flyerURLString;
@property (nonatomic, readonly) NSURL *flyerURL;
@property (nonatomic, strong) NSNumber *flyerHeight;
@property (nonatomic, strong) NSNumber *flyerWidth;

#pragma mark - Event relations

@property (nonatomic, strong) NSSet *posts;
@property (nonatomic, strong) NSSet *tickets;
@property (nonatomic, strong) NSSet *activities;

- (void)accessed;

@end

//@interface WelcuEvent (CoreDataGeneratedAccessors)
//
//- (void)addPostsObject:(WelcuPost *)value;
//- (void)removePostsObject:(WelcuPost *)value;
//- (void)addPosts:(NSSet *)values;
//- (void)removePosts:(NSSet *)values;
//
//- (void)addTicketsObject:(WelcuTicket *)value;
//- (void)removeTicketsObject:(WelcuTicket *)value;
//- (void)addTickets:(NSSet *)values;
//- (void)removeTickets:(NSSet *)values;
//
//- (void)addActivitiesObject:(WelcuActivity *)value;
//- (void)removeActivitiesObject:(WelcuActivity *)value;
//- (void)addActivities:(NSSet *)values;
//- (void)removeActivities:(NSSet *)values;
//
//@end
