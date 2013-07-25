//
//  WelcuTicketQRCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuTicketQRCell.h"
#import <QRCodeGenerator.h>

@implementation WelcuTicketQRCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor welcuLightGrey];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.ticketCodeLabel.font = [WelcuTicketCell boldFont];
    self.ticketNumberLabel.font = [WelcuTicketCell lightFont];
    self.ticketNumberLabel.textColor = [UIColor welcuDarkGrey];
}

- (void)setContent
{
    self.qrImageView.image = self.ticket.qrCodeImage;
    self.ticketCodeLabel.text = self.ticket.code;
    self.ticketNumberLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Ticket Number #%@", nil), self.ticket.ticketID];
}

@end
