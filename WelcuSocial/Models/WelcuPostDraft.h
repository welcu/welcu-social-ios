//
//  WelcuPostDraft.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/19/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WelcuEvent;

@interface WelcuPostDraft : NSManagedObject

@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * kind;
@property (nonatomic, retain) NSNumber * published;
@property (nonatomic, retain) WelcuEvent *event;

@property (readonly, getter = isUploading) BOOL uploading;

+ (WelcuPostDraft *)postDraftWithAttributes:(NSDictionary *)atributes;

- (void)startUpload;

@end
