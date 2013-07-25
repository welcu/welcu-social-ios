//
//  WelcuAccountTicketViewController.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcuTicket.h"

@interface WelcuTicketViewController : UITableViewController

@property (nonatomic,strong) WelcuTicket *ticket;

- (instancetype)initWithTicket:(WelcuTicket *)ticket;

@end
