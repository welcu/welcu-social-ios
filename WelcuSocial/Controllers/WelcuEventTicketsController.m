//
//  WelcuEventTicketsController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEventTicketsController.h"
#import "WelcuTicketViewController.h"

@interface WelcuEventTicketsController () <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic,strong) NSArray *tickets;

@end

@implementation WelcuEventTicketsController

- (void)awakeFromNib
{
    self.dataSource = self;
    self.delegate = self;
//    self.view.tintColor = [UIColor blackColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tickets = [self.event.tickets allObjects];
    
    WelcuTicket *ticket = [self.tickets firstObject];
    
    [self setViewControllers:@[[[WelcuTicketViewController alloc] initWithTicket:ticket]]
                   direction:UIPageViewControllerNavigationDirectionForward
                    animated:NO
                  completion:nil];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    WelcuTicket *ticket = [(WelcuTicketViewController *)viewController ticket];
    
    NSInteger index = [self.tickets indexOfObject:ticket];
    
    if (index + 1 < [self.tickets count]) {
        return [[WelcuTicketViewController alloc] initWithTicket:self.tickets[ index + 1 ]];
    } else {
        return nil;
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    WelcuTicket *ticket = [(WelcuTicketViewController *)viewController ticket];
    
    NSInteger index = [self.tickets indexOfObject:ticket];
    
    if (index > 0) {
        return [[WelcuTicketViewController alloc] initWithTicket:self.tickets[ index - 1 ]];
    } else {
        return nil;
    }
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.tickets count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController

{
    return 0;
}

#pragma mark - UIPageViewControllerDelegate

@end
