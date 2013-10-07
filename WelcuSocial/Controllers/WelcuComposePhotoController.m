//
//  WelcuComposePhotoController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/17/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuComposePhotoController.h"

#import <R1PhotoEffectsSDK/R1PhotoEffectsSDK.h>



@interface WelcuComposePhotoController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate,R1PhotoEffectsEditingViewControllerDelegate>

@property (weak, nonatomic) UIViewController *presentingViewController;
@property (strong, nonatomic) UIImagePickerController *mainImagePicker;

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
    
    [self.presentingViewController presentViewController:self.mainImagePicker animated:YES completion:nil];
}

- (UIImagePickerController *)buildBasePicker
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.mediaTypes = @[ (NSString *)kUTTypeImage ];
    picker.allowsEditing = NO;
    
    return picker;
}

- (UIImagePickerController *)buildCameraPicker
{
    UIImagePickerController *cameraPicker = [self buildBasePicker];
    cameraPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    return cameraPicker;
}

- (UIImagePickerController *)buildLibraryImagePicker
{
    UIImagePickerController *imagePicker = [self buildBasePicker];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    return imagePicker;
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];

    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIViewController *photoEditorController = [[R1PhotoEffectsSDK sharedManager] photoEffectsControllerForImage:image
                                                                                                       delegate:self
                                                                                                    cropSupport:YES];

    [self.presentingViewController presentViewController:photoEditorController
                                                animated:YES
                                              completion:nil];

    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];

    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - R1PhotoEffectsEditingViewControllerDelegate

- (void)photoEffectsEditingViewController:(R1PhotoEffectsEditingViewController *)controller
                       didFinishWithImage:(UIImage *)image
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

    WelcuComposeController *composeController = [WelcuComposeController composeController];
    composeController.event = self.event;
    composeController.delegate = self.delegate;
    composeController.postType = WelcuComposePhotoPostType;
    composeController.postImage = image;
    [composeController presentComposeController];
}

- (void)photoEffectsEditingViewControllerDidCancel:(R1PhotoEffectsEditingViewController *)controller
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
