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

@property (strong) NSNumber *userID;
@property (strong) NSString *firstName;
@property (strong) NSString *lastName;
@property (strong) NSString *facebookUID;

@property (readonly) WelcuEvent *lastActiveEvent;

+ (WelcuAccount *)currentAccount;

@property (readonly) NSURL *accountDocumentsDirectory;

// Related Models Access
@property (readonly) WelcuSocialClient *client;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
