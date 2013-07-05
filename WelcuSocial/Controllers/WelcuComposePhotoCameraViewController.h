//
//  WelcuComposePhotoCameraViewController.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/30/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcuComposePhotoCameraViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *flashToggleButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraToggleButton;
@property (weak, nonatomic) IBOutlet UIImageView *cameraLiveFeedImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cameraRollLastImageView;

- (IBAction)takePhoto:(id)sender;
- (IBAction)chooseFromCameraRoll:(id)sender;
- (IBAction)toggleFlash:(id)sender;
- (IBAction)toggleCamera:(id)sender;

@end
