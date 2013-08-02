//
//  WelcuMenuActionCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/23/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuMenuActionCell.h"
#import <FontasticIcons/FontasticIcons.h>

@implementation WelcuMenuActionCell

@synthesize cellType = _cellType;

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    self.backgroundColor = [UIColor clearColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = [UIColor welcuDarkGrey];
    self.menuLabel.font = [UIFont fontWithName:@"MuseoSans-700" size:15];
}

- (void)setCellType:(WelcuMenuActionCellType)cellType
{
    _cellType = cellType;
    [self setAttributes];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self setAttributes];
}

- (void)setAttributes
{
    FIIcon *icon;
    switch (self.cellType) {
        case WelcuMenuActionCellMyEventsType:
            self.menuLabel.text = @"My Events";
            icon = [FIFontAwesomeIcon calendarIcon];
            break;
        case WelcuMenuActionCellMyTicketsType:
            self.menuLabel.text = @"My Tickets";
            icon = [FIFontAwesomeIcon ticketIcon];
            break;
        case WelcuMenuActionCellDiscoverType:
            self.menuLabel.text = @"Discover events";
            icon = [FIFontAwesomeIcon searchIcon];
            break;
    }
    
    if (self.selected) {
        self.backgroundColor = [UIColor welcuDarkGrey];
        self.menuLabel.textColor = [UIColor welcuPurple];
        self.iconImageView.image = [icon imageWithBounds:self.iconImageView.bounds color:[UIColor welcuPurple]];
    } else {
        self.backgroundColor = [UIColor clearColor];
        self.menuLabel.textColor = [UIColor whiteColor];
        self.iconImageView.image = [icon imageWithBounds:self.iconImageView.bounds color:[UIColor whiteColor]];
    }
    
}

@end
