//
//  WelcuTicketQRCell.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/25/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcuTicket.h"

@interface WelcuTicketCell : UITableViewCell

@property (nonatomic,strong) WelcuTicket *ticket;

+ (UIFont *)boldFont;
+ (UIFont *)lightFont;
+ (UIFont *)lighterFont;

+ (UIColor *)blackColor;
+ (UIColor *)greyColor;

- (void)setContent;

@end
