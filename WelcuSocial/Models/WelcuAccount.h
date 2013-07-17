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

typedef void(^WelcuAccountAuthenticationCompletionHandler)(WelcuAccount *account, NSError *error);

@interface WelcuAccount : NSObject

@property (strong) NSNumber *userID;
@property (strong) NSString *firstName;
@property (strong) NSString *lastName;
@property (strong) NSString *facebookUID;

@property (nonatomic, readonly) NSString *fullName;
@property (nonatomic, readonly) NSURL *pictureURL;
- (NSURL *)pictureURLWithSize:(NSInteger)pixels;

@property (readonly) WelcuEvent *lastActiveEvent;

+ (WelcuAccount *)currentAccount;
+ (void)logOut;
+ (void)authenticateWithFacebookAccessToken:(NSString *)accessToken
                                    completionHandler:(WelcuAccountAuthenticationCompletionHandler)handler;
+ (void)authenticateWithEmail:(NSString *)email
                            andPassword:(NSString *)password
                                    completionHandler:(WelcuAccountAuthenticationCompletionHandler)handler;

@property (readonly, nonatomic) NSURL *accountDocumentsDirectory;

// Related Models Access
@property (readonly) WelcuSocialClient *client;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

- (void)saveContext;

@end
