//
//  WelcuTicketQRCell.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcuTicketCell.h"

@interface WelcuTicketQRCell : WelcuTicketCell

@property (nonatomic,weak) IBOutlet UIImageView *qrImageView;
@property (nonatomic,weak) IBOutlet UILabel *ticketCodeLabel;
@property (nonatomic,weak) IBOutlet UILabel *ticketNumberLabel;

@end
