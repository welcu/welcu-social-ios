//
//  WelcuUser.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WelcuPost;

@interface WelcuUser : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * facebookUID;
@property (nonatomic, retain) NSSet *posts;
@end

@interface WelcuUser (CoreDataGeneratedAccessors)

- (void)addPostsObject:(WelcuPost *)value;
- (void)removePostsObject:(WelcuPost *)value;
- (void)addPosts:(NSSet *)values;
- (void)removePosts:(NSSet *)values;

@end
