//
//  WelcuTicketNameCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuTicketNameCell.h"

@implementation WelcuTicketNameCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.nameLabel.font = [WelcuTicketCell boldFont];
    self.emailLabel.font = [WelcuTicketCell lightFont];
    self.emailLabel.textColor = [WelcuTicketCell greyColor];
}

- (void)setContent
{
    self.nameLabel.text = self.ticket.personFullName;
    self.emailLabel.text = self.ticket.personEmail;
}

@end
