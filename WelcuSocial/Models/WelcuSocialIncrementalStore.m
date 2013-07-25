//
//  WelcuSocialIncrementalStore.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuSocialIncrementalStore.h"
#import "WelcuAccount.h"


@implementation WelcuSocialIncrementalStore
+ (void)initialize {
    [NSPersistentStoreCoordinator registerStoreClass:self forStoreType:[self type]];
}

+ (NSString *)type {
    return NSStringFromClass(self);
}

+ (NSManagedObjectModel *)model {
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"WelcuSocial" withExtension:@"momd"]];
}

- (id<AFIncrementalStoreHTTPClient>)HTTPClient {
    return [[WelcuAccount currentAccount] client];
}

//- (id)executeSaveChangesRequest:(NSSaveChangesRequest *)saveChangesRequest
//                    withContext:(NSManagedObjectContext *)context
//                          error:(NSError *__autoreleasing *)error
//{
//    NSManagedObjectContext *backingContext = [self backingManagedObjectContext];
//    [backingContext performBlockAndWait:^{
//        NSManagedObject *backingObject = [backingContext existingObjectWithID:updatedObject.objectID error:nil];
//        [backingObject setValuesForKeysWithDictionary:[updatedObject dictionaryWithValuesForKeys:nil]];
//        [backingContext save:nil];
//    }];
//    
//    // Do nothing since we are not saving data to the server from Core Data
//    return self;
//}

@end
