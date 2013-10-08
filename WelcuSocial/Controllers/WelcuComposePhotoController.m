//
//  WelcuComposePhotoController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/17/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuComposePhotoController.h"

#import <R1PhotoEffectsSDK/R1PhotoEffectsSDK.h>
#import <GCBActionSheet/GCBActionSheet.h>



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

    self.presentingViewController = controller;
    currentComposePhotoController = self;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        GCBActionSheet *selector = [[GCBActionSheet alloc] init];
        // selector.title = @"Select "
        [selector addCancelButtonWithTitle:@"Take Photo" handler:^{
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
            self.mainImagePicker = [self buildCameraPicker];
            [self.presentingViewController presentViewController:self.mainImagePicker
                                                        animated:YES
                                                      completion:nil];
        }];

        [selector addCancelButtonWithTitle:@"Choose from Library" handler:^{
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
            self.mainImagePicker = [self buildLibraryImagePicker];
            [self.presentingViewController presentViewController:self.mainImagePicker
                                                        animated:YES
                                                      completion:nil];
        }];

        [selector addCancelButtonWithTitle:@"Cancel" handler:^{
            currentComposePhotoController = nil;
        }];

        [selector showInView:self.presentingViewController.view];

    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        self.mainImagePicker = [self buildLibraryImagePicker];
        [self.presentingViewController presentViewController:self.mainImagePicker animated:YES completion:nil];
    }
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

    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
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

    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    }];
}

- (void)photoEffectsEditingViewControllerDidCancel:(R1PhotoEffectsEditingViewController *)controller
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end
