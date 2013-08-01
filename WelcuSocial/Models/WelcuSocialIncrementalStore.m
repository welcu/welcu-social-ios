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

@end
