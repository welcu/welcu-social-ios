//
//  WelcuLoginViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

#import "WelcuAccount.h"
#import "WelcuStartViewController.h"

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
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:
     ^(FBSession *session,
       FBSessionState state, NSError *error) {
         [self facebookSessionStateChanged:session state:state error:error];
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
    [WelcuAccount authenticateWithFacebookAccessToken:accessToken completionHandler:^(WelcuAccount *account, NSError *error) {
        
        if (error) {
            [self loginFailed];
            return;
        }
        
        [(WelcuStartViewController *)self.presentingViewController presentMainViewAnimated:YES];
    }];
}

- (void)authenticateWithEmail:(NSString *)email andPassword:(NSString *)password
{
    [WelcuAccount authenticateWithEmail:email andPassword:password completionHandler:^(WelcuAccount *account, NSError *error) {
        
        if (error) {
            [self loginFailed];
            return;
        }
        
        
        
        [(WelcuStartViewController *)self.presentingViewController presentMainViewAnimated:YES];
    }];
}


- (IBAction)loginButtonPressed:(id)sender
{
//    [self facebookLoggin];
    [self authenticateWithFacebookAccessToken:@"facebook!"];
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

@end
