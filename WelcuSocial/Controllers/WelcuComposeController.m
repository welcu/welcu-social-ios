//
//  WelcuComposeController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/8/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuComposeController.h"

#import <FontasticIcons/FontasticIcons.h>
#import <TTSwitch/TTSwitch.h>
#import <FacebookSDK/FacebookSDK.h>

#import "WelcuUserAccount.h"
#import "WelcuPostDraft.h"
#import "WelcuComposeToggleSwitch.h"

@interface WelcuComposeController ()

@property (strong,nonatomic) WelcuUserAccount *account;

@property (nonatomic,strong) UIView *overlayView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIImageView *contentPhotoView;
@property (readonly) NSArray *shareButtons;

@property (readonly, nonatomic) WelcuComposeToggleSwitch *facebookToggleSwitch;
@property (readonly, nonatomic) WelcuComposeToggleSwitch *twitterToggleSwitch;

- (void)toggleFacebook:(WelcuComposeToggleSwitch *)sender;
- (void)toggleTwitter:(WelcuComposeToggleSwitch *)sender;
- (void)toggleFoursquare:(WelcuComposeToggleSwitch *)sender;
- (void)toggleInstagram:(WelcuComposeToggleSwitch *)sender;
- (void)toggleLinkedin:(WelcuComposeToggleSwitch *)sender;

- (void)dismissComposeController;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end

// Hack to keep a retain on the currently active compose controller
static WelcuComposeController *currentComposeController = nil;

@implementation WelcuComposeController

+ (WelcuComposeController *)composeController
{
    return [[WelcuComposeController alloc] initWithNibName:@"WelcuComposeController" bundle: nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.postType = WelcuComposePlainPostType;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (![[WelcuAccount currentAccount] isGuest]) {
        self.account = (WelcuUserAccount *)[WelcuAccount currentAccount];
    }
    
    self.view.layer.cornerRadius = 5;
    // Do any additional setup after loading the view from its nib.
    
    if (self.postImage) {
        self.contentPhotoView.image = self.postImage;
        self.contentPhotoView.layer.cornerRadius = 5;
        self.contentPhotoView.transform = CGAffineTransformMakeRotation(0.2);
    } else {
        self.contentPhotoView.hidden = YES;
        // [self.contentPhotoView removeFromSuperview];
    }
    
    [[self.navigationBar.items[0] rightBarButtonItem] setTitleTextAttributes:@{
                                                                              UITextAttributeFont : [UIFont fontWithName:@"MuseoSans-700" size:17],
                                                                              UITextAttributeTextColor : [UIColor welcuGreen]
                                                                              }
                                                                    forState:UIControlStateNormal];
    
    [self.toolbar setItems:self.shareButtons];
    
    self.contentTextView.tintColor = [UIColor blackColor];
}

- (NSArray *)shareButtons
{
    NSMutableArray *shareButtons = [NSMutableArray array];
    [shareButtons addObject:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil]];
    [shareButtons addObject:[[UIBarButtonItem alloc] initWithCustomView:self.twitterToggleSwitch]];
    [shareButtons addObject:[[UIBarButtonItem alloc] initWithCustomView:self.facebookToggleSwitch]];
    
    return shareButtons;
}

- (void)presentComposeController
{
    if (!self.event) return;

    currentComposeController = self;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    self.overlayView = [[UIView alloc] initWithFrame:window.frame];
    self.overlayView.backgroundColor = [UIColor colorWithWhite:0.25 alpha:0];
    [window addSubview:self.overlayView];
    
    self.view.frame = CGRectMake(15, -200, window.frame.size.width - 30, 200);
    [self.overlayView addSubview:self.view];
    [self.contentTextView becomeFirstResponder];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overlayView.backgroundColor = [UIColor colorWithWhite:0.25 alpha:0.9];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(15, 30, window.frame.size.width - 30, 200);
        } completion:nil];
    }];
}

- (void)dismissComposeController
{
    [self.contentTextView resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(15, -200, self.view.superview.frame.size.width - 30, 200);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.overlayView.backgroundColor = [UIColor colorWithWhite:0.25 alpha:0.0];
        } completion:^(BOOL finished) {
            [self.overlayView removeFromSuperview];
            currentComposeController = nil;
        }];
    }];
}

#pragma mark Actions

- (void)done:(id)sender
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];

    attributes[@"event"] = self.event;
    attributes[@"facebook"] = @( self.facebookToggleSwitch.on );
    attributes[@"twitter"] = @( self.twitterToggleSwitch.on );
    if (self.contentTextView.text) {
        attributes[@"content"] = self.contentTextView.text;
    }
    
    if (self.postImage) {
        attributes[@"photo"] = self.postImage;
    }
    
    WelcuPostDraft *post = [WelcuPostDraft postDraftWithAttributes:attributes];
    
    [post startUpload];
    
    [self dismissComposeController];
    [self.delegate composeController:self didFinishedComposingPost:post];
}
- (void)cancel:(id)sender
{
    [self dismissComposeController];
}

@synthesize facebookToggleSwitch = _facebookToggleSwitch;

- (WelcuComposeToggleSwitch *)facebookToggleSwitch
{
    if (!_facebookToggleSwitch) {
        _facebookToggleSwitch = [WelcuComposeToggleSwitch facebookToggleSwitch];
        _facebookToggleSwitch.on = [self.account isFacebookEnabled];
        [_facebookToggleSwitch addTarget:self action:@selector(toggleFacebook:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _facebookToggleSwitch;
}

- (void)toggleFacebook:(WelcuComposeToggleSwitch *)sender
{
    if ([sender isOn]) {
        if ([self.account isFacebookAuthorized]) {
            self.account.facebookEnabled = YES;
        } else {
            [self.account authorizeFacebookWithCompletionHandler:^(BOOL granted, NSError *error) {
                if (error || !granted) {
                    sender.on = NO;
                    return;
                }
                
                self.account.facebookEnabled = YES;
            }];
        }
    } else {
        self.account.facebookEnabled = NO;
    }
}

@synthesize twitterToggleSwitch = _twitterToggleSwitch;

- (WelcuComposeToggleSwitch *)twitterToggleSwitch
{
    if (!_twitterToggleSwitch) {
        _twitterToggleSwitch = [WelcuComposeToggleSwitch twitterToggleSwitch];
        _twitterToggleSwitch.on = [self.account isTwitterEnabled];
        [_twitterToggleSwitch addTarget:self action:@selector(toggleTwitter:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _twitterToggleSwitch;
}

- (void)toggleTwitter:(WelcuComposeToggleSwitch *)sender
{
    if ([sender isOn]) {
        if ([self.account isFacebookAuthorized]) {
            self.account.twitterEnabled = YES;
        } else {
            [self.account authorizeTwitterWithCompletionHandler:^(BOOL granted, NSError *error) {
                if (error || !granted) {
                    sender.on = NO;
                    return;
                }
                
                self.account.twitterEnabled = YES;
            }];
        }
    } else {
        self.account.twitterEnabled = NO;
    }
}

- (void)toggleFoursquare:(WelcuComposeToggleSwitch *)sender
{
    
}

- (void)toggleInstagram:(WelcuComposeToggleSwitch *)sender
{
    
}

- (void)toggleLinkedin:(WelcuComposeToggleSwitch *)sender
{
}

@end
