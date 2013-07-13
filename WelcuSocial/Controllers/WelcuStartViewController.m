//
//  WelcuStartViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuStartViewController.h"

#import <FacebookSDK/FacebookSDK.h>

#import "WelcuLoginViewController.h"


@interface WelcuStartViewController ()
- (void)openSession;
- (void)showLoginView;
@end

@implementation WelcuStartViewController

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            if ([self.presentedViewController isKindOfClass:[WelcuLoginViewController class]]) {
                [self dismissViewControllerAnimated:YES completion:^{}];
            }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            // Once the user has logged in, we want them to
            // be looking at the root view.
            [self dismissViewControllerAnimated:NO completion:nil];
            [FBSession.activeSession closeAndClearTokenInformation];
            [self showLoginView];
            break;
        default:
            break;
    }
    
    if (error) {
        DDLogError(@"Facebook Login Error: %@", error);
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error"
                                  message:error.localizedDescription
                                  delegate:nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)openSession
{
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self sessionStateChanged:session state:state error:error];
     }];
}

- (void)showLoginView
{
    // If the login screen is not already displayed, display it. If the login screen is
    // displayed, then getting back here means the login in progress did not successfully
    // complete. In that case, notify the login view so it can update its UI appropriately.
    if (![self.presentedViewController isKindOfClass:[WelcuLoginViewController class]]) {
        [self performSegueWithIdentifier:@"WelcuLoginViewController" sender:self];
    } else {
        WelcuLoginViewController* loginViewController =
        (WelcuLoginViewController *)self.presentedViewController;
        [loginViewController loginFailed];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // Yes, so just open the session (this won't display any UX).
        [self openSession];
    } else {
        // No, display the login page.
        [self showLoginView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
