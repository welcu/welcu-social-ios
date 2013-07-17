//
//  NSFetchRequest+UserInfo.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/16/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSFetchRequest (ServerContext)

@property (strong, nonatomic) id serverContext;

@end
