//
//  WelcuComposeController.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/8/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WelcuEvent;
@class WelcuComposeController;

typedef enum {
    WelcuComposePlainPostType,
    WelcuComposeQuotePostType,
    WelcuComposePhotoPostType,
    WelcuComposeCheckinPostType,
} WelcuComposePostType;


@protocol WelcuComposeControllerDelegate <NSObject>

@required

-(void)composeController:(WelcuComposeController *)controller didFinishedComposingPost:(id)post;

@optional

-(void)composeControllerDidCancel:(WelcuComposeController *)controller;

@end


@interface WelcuComposeController : UIViewController

+ (WelcuComposeController *)composeController;

@property (nonatomic,weak) id<WelcuComposeControllerDelegate> delegate;
@property (nonatomic,strong) WelcuEvent *event;
@property (nonatomic,assign) WelcuComposePostType postType;
@property (nonatomic,strong) UIImage *postImage;

-(void)presentComposeController;
-(void)dismissComposeController;

- (IBAction)finishComposing:(id)sender;
- (IBAction)dismissComposeController:(id)sender;


@end
