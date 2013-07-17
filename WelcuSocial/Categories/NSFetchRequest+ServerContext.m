//
//  NSFetchRequest+UserInfo.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/16/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "NSFetchRequest+ServerContext.h"
#import <objc/runtime.h>

static char kNSFetchRequestServerContextObjectKey;

@implementation NSFetchRequest (ServerContext)

- (id)serverContext
{
    return objc_getAssociatedObject(self, &kNSFetchRequestServerContextObjectKey);
}

- (void)setServerContext:(id)serverContext
{
    objc_setAssociatedObject(self, &kNSFetchRequestServerContextObjectKey, serverContext, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
