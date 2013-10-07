//
//  WelcuComposePhotoController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/17/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuComposePhotoController.h"

#import <GKImagePicker/GKImagePicker.h>

#import <R1PhotoEffectsSDK/R1PhotoEffectsSDK.h>



@interface WelcuComposePhotoController () <UINavigationControllerDelegate,GKImagePickerDelegate,R1PhotoEffectsEditingViewControllerDelegate>

@property (weak, nonatomic) UIViewController *presentingViewController;
@property (strong, nonatomic) GKImagePicker *mainImagePicker;

@end

// Hack to keep a retain on the currently active compose controller
static WelcuComposePhotoController *currentComposePhotoController = nil;

@implementation WelcuComposePhotoController

+ (WelcuComposePhotoController *)composePhotoController
{
    return [[WelcuComposePhotoController alloc] init];
}

-(void)presentComposeControllerOn:(UIViewController *)controller
{
    if (!self.event) return;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];

    self.presentingViewController = controller;
    currentComposePhotoController = self;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.mainImagePicker = [self buildCameraPicker];
    } else {
        self.mainImagePicker = [self buildLibraryImagePicker];
    }
    
    [self.presentingViewController presentViewController:self.mainImagePicker.imagePickerController animated:YES completion:nil];
}

- (GKImagePicker *)buildBasePicker
{
    GKImagePicker *picker = [[GKImagePicker alloc] init];
    picker.cropSize = CGSizeMake(300, 300);
    picker.delegate = self;
    picker.imagePickerController.mediaTypes = @[ (NSString *)kUTTypeImage ];
//    picker.imagePickerController.allowsEditing = NO;
    
    return picker;
}

- (GKImagePicker *)buildCameraPicker
{
    GKImagePicker *cameraPicker = [self buildBasePicker];
    cameraPicker.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    return cameraPicker;
}

- (GKImagePicker *)buildLibraryImagePicker
{
    GKImagePicker *imagePicker = [self buildBasePicker];
    imagePicker.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    return imagePicker;
}

#pragma mark - GKImagePickerDelegate
- (void)imagePicker:(GKImagePicker *)imagePicker pickedImage:(UIImage *)image
{
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];

}
- (void)imagePickerDidCancel:(GKImagePicker *)imagePicker
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];

    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
//    if (imagePicker == self.mainImagePicker) {
//        currentComposePhotoController = nil;
//        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        [self.mainImagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
//    }
}

#pragma mark - R1PhotoEffectsEditingViewControllerDelegate



@end
