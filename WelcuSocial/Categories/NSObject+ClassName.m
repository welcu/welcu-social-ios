//
//  NSObject+ClassName.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/29/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "NSObject+ClassName.h"

@implementation NSObject (ClassName)

+ (NSString *)className
{
    return NSStringFromClass([self class]);
}

@end
