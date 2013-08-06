//
//  WelcuLoginViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import <FontasticIcons/FontasticIcons.h>

#import "WelcuAccount.h"
#import "WelcuUserAccount.h"

@interface WelcuLoginViewController ()


- (void)facebookLoggin;
- (void)facebookSessionStateChanged:(FBSession *)session
                              state:(FBSessionState) state
                              error:(NSError *)error;
- (void)authenticateWithFacebookAccessToken:(NSString *)accessToken;
- (void)authenticateWithEmail:(NSString *)email andPassword:(NSString *)password;

@end

@implementation WelcuLoginViewController

- (void)loginFailed
{
    // TODO
}

- (void)facebookLoggin
{
    [FBSession openActiveSessionWithReadPermissions:@[@"email", @"user_location"]
                                       allowLoginUI:YES
                                  completionHandler: ^(FBSession *session, FBSessionState state, NSError *error)
    {
        [self facebookSessionStateChanged:session
                                    state:state
                                    error:error];
    }];
    
}

- (void)facebookSessionStateChanged:(FBSession *)session
                              state:(FBSessionState) state
                              error:(NSError *)error
{
    switch (state) {
        case FBSessionStateOpen:
            [self authenticateWithFacebookAccessToken:session.accessTokenData.accessToken];
            break;
            
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:
            [FBSession.activeSession closeAndClearTokenInformation];
            [self loginFailed];
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

- (void)authenticateWithFacebookAccessToken:(NSString *)accessToken
{
    [WelcuUserAccount authenticateWithFacebookAccessToken:accessToken completionHandler:^(WelcuUserAccount *account, NSError *error) {
        
        if (error) {
            [self loginFailed];
            return;
        }
    }];
}

- (void)authenticateWithEmail:(NSString *)email andPassword:(NSString *)password
{
    [WelcuUserAccount authenticateWithEmail:email andPassword:password completionHandler:^(WelcuUserAccount *account, NSError *error) {
        
        if (error) {
            [self loginFailed];
            return;
        }

    }];
}


- (IBAction)dismissLogin:(id)sender
{
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginButtonPressed:(id)sender
{
    [self facebookLoggin];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.facebookSignInButton.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, self.facebookSignInButton.frame.size.width-45);
    [self.facebookSignInButton setImage:[[FIFontAwesomeIcon facebookIcon] imageWithBounds:CGRectMake(0, 0, 25, 25)
                                                                                    color:[UIColor whiteColor]]
                               forState:UIControlStateNormal];
//    self.facebookSignInButton.imageView.image = [[FIFontAwesomeIcon facebookIcon] imageWithBounds:CGRectMake(0, 0, 30, 30) color:[UIColor whiteColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
