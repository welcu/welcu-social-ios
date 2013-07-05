//
//  WelcuEventFeedViewController.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WelcuEventFeedViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (strong) id event;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *composeButton;

- (IBAction)startComposeAction:(id)sender;

@end
