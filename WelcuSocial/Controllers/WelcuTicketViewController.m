//
//  WelcuAccountTicketViewController.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuTicketViewController.h"
#import "WelcuTicketCell.h"

@interface WelcuTicketViewController ()

@end

@implementation WelcuTicketViewController

- (instancetype)initWithTicket:(WelcuTicket *)ticket
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.ticket = ticket;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"WelcuTicketQRCell" bundle:nil]
         forCellReuseIdentifier:@"WelcuTicketQRCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WelcuTicketNameCell" bundle:nil]
         forCellReuseIdentifier:@"WelcuTicketNameCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    WelcuTicketCell *cell = nil;
    
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"WelcuTicketQRCell"];
    } else if (indexPath.row == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"WelcuTicketNameCell"];
    }
    
    cell.ticket = self.ticket;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return 250;
    if (indexPath.row == 1) return 66;
    
    return 0;
}


@end
