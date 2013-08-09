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
@class WelcuPostDraft;

@protocol WelcuPostDraftProgressDelegate <NSObject>

- (void)postDraft:(WelcuPostDraft *)postDraft uploadProgressedTo:(CGFloat)progress;

@end

@interface WelcuPostDraft : NSManagedObject

@property (nonatomic, retain) NSData * photo;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * kind;
@property (nonatomic, retain) NSNumber * published;
@property (nonatomic, retain) WelcuEvent *event;
@property (nonatomic, retain) NSNumber * facebookEnabled;
@property (nonatomic, retain) NSNumber * twitterEnabled;
@property (nonatomic, retain) NSDate * createdAt;

@property (nonatomic, weak) id<WelcuPostDraftProgressDelegate> progressDelegate;
@property (nonatomic, assign) CGFloat progress;
@property (readonly, getter = isUploading) BOOL uploading;

+ (WelcuPostDraft *)postDraftWithAttributes:(NSDictionary *)atributes;

- (void)startUpload;

@end
