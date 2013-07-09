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


- (void)toggleFacebook:(UIBarButtonItem *)sender;
- (void)toggleTwitter:(UIBarButtonItem *)sender;
- (void)toggleFoursquare:(UIBarButtonItem *)sender;
- (void)toggleInstagram:(UIBarButtonItem *)sender;
- (void)toggleLinkedin:(UIBarButtonItem *)sender;

- (void)dismissComposeController;

@end

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
    
    [shareButtons addObject:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ShareSwitchFacebookDisabled"]
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(toggleFacebook:)]];
    
    [self.toolbar setItems:shareButtons];
}

- (void)presentComposeController
{
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
            // Hack to show keyboard
            UITextField *f = [[UITextField alloc] initWithFrame:CGRectZero];
            [self.overlayView addSubview:f];
            f.keyboardAppearance = UIKeyboardAppearanceDark;
            [f becomeFirstResponder];
        }];
    }];
    
}

- (void)dismissComposeController
{
//    [self.overlayView removeFromSuperview];
//    UIView animateWithDuration:<#(NSTimeInterval)#> animations:<#^(void)animations#> completion:<#^(BOOL finished)completion#>
}

#pragma mark Actions
- (IBAction)finishComposing:(id)sender;
{
    [self dismissComposeController];
}

- (IBAction)dismissComposeController:(id)sender;
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
