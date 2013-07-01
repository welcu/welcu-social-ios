//
//  WelcuEventViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventViewController.h"
#import <ALRadial/ALRadialMenu.h>


@interface WelcuEventViewController () <ALRadialMenuDelegate>

@property (strong) ALRadialMenu *composeMenu;

@end

@implementation WelcuEventViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Webprendedor 2013";
    self.composeMenu = [[ALRadialMenu alloc] init];
    self.composeMenu.delegate = self;

	// Do any additional setup after loading the view.
}

- (IBAction)startComposeAction:(id)sender {
    [self.composeMenu buttonsWillAnimateFromButton:sender
                                         withFrame:CGRectMake(0, 0, 20, 20)
                                            inView:self.view];
}


#pragma mark ALRadialMenuDelegate

- (NSInteger) numberOfItemsInRadialMenu:(ALRadialMenu *)radialMenu {
	return 3;
}

- (NSInteger)arcRadiusForRadialMenu:(ALRadialMenu *)radialMenu
{
    return 90;
}

- (NSInteger)arcSizeForRadialMenu:(ALRadialMenu *)radialMenu
{
    return 80;
}

- (NSInteger)arcStartForRadialMenu:(ALRadialMenu *)radialMenu
{
    return 0;
}

- (float)buttonSizeForRadialMenu:(ALRadialMenu *)radialMenu
{
    return 0;
}

- (void)radialMenu:(ALRadialMenu *)radialMenu didSelectItemAtIndex:(NSInteger)index
{
//    [self.composeMenu itemsWillDisapearIntoButton:self.composeButton];
}

- (UIImage *)radialMenu:(ALRadialMenu *)radialMenu imageForIndex:(NSInteger)index
{
    return [UIImage imageNamed:@"FeedTabIcon"];
}

@end
