//
//  WelcuComposePhotoController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/17/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuComposePhotoController.h"

@interface WelcuComposePhotoController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

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
    picker.mediaTypes = @[ (NSString *)kUTTypeImage ];
    picker.allowsEditing = NO;
    picker.delegate = self;
    
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
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (picker == self.mainImagePicker) {
        currentComposePhotoController = nil;
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.mainImagePicker dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
