//
//  WelcuComposePhotoCameraViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/30/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuComposePhotoCameraViewController.h"

//#import <R1PhotoEffectsSDK/R1PhotoEffectsSDK.h>

@interface WelcuComposePhotoCameraViewController () //<R1PhotoEffectsEditingViewControllerDelegate>

- (void)continueWithImage:(UIImage *)image;

@end

@implementation WelcuComposePhotoCameraViewController

- (void)continueWithImage:(UIImage *)image
{
//    R1PhotoEffectsController *controller = [[R1PhotoEffectsSDK sharedManager] photoEffectsControllerForImage:image
//                                                                                                    delegate:self
//                                                                                                 cropSupport:YES];
//    [self presentViewController:controller animated:YES completion:^{
//        
//    }];
    
//    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(id)sender {
    [self continueWithImage:[UIImage imageNamed:@"SamplePhoto"]];
}

- (IBAction)chooseFromCameraRoll:(id)sender {
    [self continueWithImage:[UIImage imageNamed:@"SamplePhoto"]];
}

- (IBAction)toggleFlash:(id)sender {

}

- (IBAction)toggleCamera:(id)sender {

}

//#pragma mark R1PhotoEffectsEditingViewControllerDelegate
//
//- (void)photoEffectsEditingViewController:(R1PhotoEffectsEditingViewController *)controller didFinishWithImage:(UIImage *)image
//{
//}
//
//- (void)photoEffectsEditingViewControllerDidCancel:(R1PhotoEffectsEditingViewController *)controller
//{
//}

@end
