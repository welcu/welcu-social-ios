//
//  WelcuAccount.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuAccount.h"
#import "WelcuSocialIncrementalStore.h"
#import "WelcuAppDelegate.h"

static WelcuAccount *currentAccount = nil;

@interface WelcuAccount ()

@property (strong) WelcuSocialClient *client;

- (id)initWithAttributes:(NSDictionary *)attributes;

@end

@implementation WelcuAccount


- (id)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.userID = attributes[@"id"];
        self.firstName = attributes[@"first_name"];
        self.lastName = attributes[@"last_name"];
        self.facebookUID = attributes[@"facebook_uid"];
    }
    return self;
}

+ (WelcuAccount *)currentAccount
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentAccount = [[WelcuAccount alloc] initWithAttributes:@{
                                                                    @"id" : @1,
                                                                    @"first_name" : @"Seba",
                                                                    @"last_name" : @"Gamboa",
                                                                    @"facebook_uid" : @"754027414",
                                                                    }];
    });
    
    return currentAccount;
}

- (NSURL *)accountDocumentsDirectory
{
    static NSURL *accountDocumentsDirectory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        accountDocumentsDirectory = [NSURL URLWithString: [self.userID stringValue]
                                           relativeToURL:[(WelcuAppDelegate *)[[UIApplication sharedApplication] delegate] applicationDocumentsDirectory]];
        NSLog(@"%@", [accountDocumentsDirectory path]);
        
        [[NSFileManager defaultManager] createDirectoryAtURL:accountDocumentsDirectory
                                 withIntermediateDirectories:NO
                                                  attributes:nil
                                                       error:nil];
     });

    return accountDocumentsDirectory;
}

#pragma mark - Core Data
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
    if (__managedObjectContext != nil) {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        __managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    
    return __managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WelcuSocial" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return __managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    AFIncrementalStore *incrementalStore = (AFIncrementalStore *)[__persistentStoreCoordinator addPersistentStoreWithType:[WelcuSocialIncrementalStore type] configuration:nil URL:nil options:nil error:nil];
    
    NSURL *storeURL = [[self accountDocumentsDirectory] URLByAppendingPathComponent:@"WelcuSocial.sqlite"];
    
    NSDictionary *options = @{
                              NSInferMappingModelAutomaticallyOption : @(YES),
                              NSMigratePersistentStoresAutomaticallyOption: @(YES)
                              };
    
    NSError *error = nil;
    if (![incrementalStore.backingPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                          configuration:nil
                                                                                    URL:storeURL
                                                                                options:options
                                                                                  error:&error]) {
        DDLogError(@"Unresolved error %@, %@", error, [error userInfo]);
        [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
        abort();
    }
    
    DDLogInfo(@"SQLite URL: %@", storeURL);
    
    return __persistentStoreCoordinator;
}


@end
