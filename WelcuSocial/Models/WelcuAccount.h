//
//  WelcuAccount.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WelcuSocialClient.h"

#import "WelcuEvent.h"

@interface WelcuAccount : NSObject

#pragma mark - Authentication

+ (WelcuAccount *)currentAccount;
- (void)signOut;
- (void)signIn;

#pragma mark - Abstract Methods

@property (strong, readonly) NSNumber *userID;
@property (strong, readonly) NSString *firstName;
@property (strong, readonly) NSString *lastName;
@property (strong, readonly) NSString *facebookUID;
@property (readonly, getter = isGuest) BOOL guest;
- (NSURL *)pictureURLWithSize:(NSInteger)pixels;
@property (readonly) WelcuEvent *lastActiveEvent;
@property (readonly, nonatomic) NSURL *accountDocumentsDirectory;


#pragma mark - Account Methods

@property (nonatomic, readonly) WelcuSocialClient *client;
@property (nonatomic, readonly) NSString *fullName;
@property (nonatomic, readonly) NSURL *pictureURL;


#pragma mark - Data methods

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
- (void)saveContext;

@end
