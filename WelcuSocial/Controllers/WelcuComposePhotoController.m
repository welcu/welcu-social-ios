//
//  WelcuComposePhotoController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/17/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuComposePhotoController.h"

#import <GKImagePicker/GKImagePicker.h>
#import <AviarySDK/AFPhotoEditorController.h>


@interface WelcuComposePhotoController () <UINavigationControllerDelegate,GKImagePickerDelegate,AFPhotoEditorControllerDelegate>

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
    AFPhotoEditorController *editorController = [[AFPhotoEditorController alloc] initWithImage:image];
    
    editorController.view.tintColor = [UIColor welcuDarkGrey];
    
    [editorController setDelegate:self];
    
    [self.presentingViewController dismissViewControllerAnimated:NO completion:nil];

    
    [self.presentingViewController presentViewController:editorController animated:YES completion:nil];

}
- (void)imagePickerDidCancel:(GKImagePicker *)imagePicker
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
//    if (imagePicker == self.mainImagePicker) {
//        currentComposePhotoController = nil;
//        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        [self.mainImagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
//    }
}


//#pragma mark - UIImagePickerControllerDelegate
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    AFPhotoEditorController *editorController = [[AFPhotoEditorController alloc] initWithImage:info[UIImagePickerControllerOriginalImage]];
//    
//    [editorController setDelegate:self];
//    
//    [self.mainImagePicker.imagePickerController presentViewController:editorController animated:YES completion:nil];
//
//}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    if (picker == self.mainImagePicker.imagePickerController) {
//        currentComposePhotoController = nil;
//        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        [self.mainImagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
//    }
//}

#pragma mark - AFPhotoEditorControllerDelegate

- (void)photoEditor:(AFPhotoEditorController *)editor finishedWithImage:(UIImage *)image
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
    WelcuComposeController *composeController = [WelcuComposeController composeController];
    composeController.event = self.event;
    composeController.postType = WelcuComposePhotoPostType;
    composeController.postImage = image;
    [composeController presentComposeController];
}

- (void)photoEditorCanceled:(AFPhotoEditorController *)editor
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    [self.mainImagePicker.imagePickerController dismissViewControllerAnimated:YES completion:nil];
}



@end
