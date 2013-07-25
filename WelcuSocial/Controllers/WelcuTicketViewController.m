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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    WelcuTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WelcuTicketQRCell"];
    
    cell.ticket = self.ticket;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return 250;
    
    return 0;
    
}


@end
