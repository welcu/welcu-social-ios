//
//  WelcuComposeController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/8/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuComposeController.h"

@interface WelcuComposeController ()

@property (nonatomic,strong) UIView *overlayView;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;


- (void)toggleFacebook:(UIBarButtonItem *)sender;
- (void)toggleTwitter:(UIBarButtonItem *)sender;
- (void)toggleFoursquare:(UIBarButtonItem *)sender;
- (void)toggleInstagram:(UIBarButtonItem *)sender;
- (void)toggleLinkedin:(UIBarButtonItem *)sender;

- (void)dismissComposeController;
- (void)done:(id)sender;
- (void)cancel:(id)sender;

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
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray *shareButtons = [NSMutableArray array];
    
    [self.toolbar setBarTintColor:[UIColor blackColor]];
    [self.toolbar addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[toolbar(33)]"
                                             options:NSLayoutFormatAlignAllBottom
                                             metrics:nil
                                               views:@{@"toolbar":self.toolbar}]];
    
    UIBarButtonItem *facebookShareButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ShareSwitchFacebookDisabled"]
                                                                            style:UIBarButtonItemStylePlain
                                                                           target:self
                                                                           action:@selector(toggleFacebook:)];
    facebookShareButton.tintColor = [UIColor blueColor];
    [shareButtons addObject:facebookShareButton];
    [self.toolbar setItems:shareButtons];
    
    self.contentTextView.tintColor = [UIColor blackColor];
    
    UINavigationItem *nav = [[UINavigationItem alloc] initWithTitle:@""];
    nav.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                          target:self
                                                                          action:@selector(cancel:)];
    nav.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                           target:self
                                                                           action:@selector(done:)];
    
    self.navigationBar.items = @[nav];
}

- (void)presentComposeController
{
    currentComposeController = self;
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    
    self.overlayView = [[UIView alloc] initWithFrame:window.frame];
    self.overlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    [window addSubview:self.overlayView];
    
    self.view.frame = CGRectMake(15, -200, window.frame.size.width - 30, 200);
    [self.overlayView addSubview:self.view];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.overlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.view.frame = CGRectMake(15, 30, window.frame.size.width - 30, 200);
        } completion:^(BOOL finished) {
            [self.contentTextView becomeFirstResponder];
        }];
    }];
}

- (void)dismissComposeController
{
    [self.contentTextView resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.frame = CGRectMake(15, -200, self.view.superview.frame.size.width - 30, 200);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.overlayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        } completion:^(BOOL finished) {
            [self.overlayView removeFromSuperview];
            currentComposeController = nil;
        }];
    }];
}

#pragma mark Actions

- (void)done:(id)sender
{
    [self dismissComposeController];
}
- (void)cancel:(id)sender
{
    [self dismissComposeController];
}

- (void)toggleFacebook:(UIBarButtonItem *)sender
{
    
}

- (void)toggleTwitter:(UIBarButtonItem *)sender
{
    
}

- (void)toggleFoursquare:(UIBarButtonItem *)sender
{
    
}

- (void)toggleInstagram:(UIBarButtonItem *)sender
{
    
}

- (void)toggleLinkedin:(UIBarButtonItem *)sender
{
}

@end
