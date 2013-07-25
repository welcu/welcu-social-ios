//
//  WelcuTicketQRCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuTicketQRCell.h"

@implementation WelcuTicketQRCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor welcuLightGrey];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setContent
{
//    self.qrImageView.image =
    self.ticketCodeLabel.text = self.ticket.code;
//    self.ticketNumberLabel.text = self.ticket.ticketID
}

@end
