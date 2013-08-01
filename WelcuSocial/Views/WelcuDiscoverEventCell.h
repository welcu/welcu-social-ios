//
//  WelcuDiscoverEventCell.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/26/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NPRImageView/NPRImageView.h>

#import "WelcuEvent.h"

@interface WelcuDiscoverEventCell : UICollectionViewCell

@property (nonatomic,strong) WelcuEvent *event;

@property (nonatomic,weak) IBOutlet NPRImageView *eventFlyerImage;
@property (nonatomic,weak) IBOutlet UILabel *eventNameLabel;
@property (nonatomic,weak) IBOutlet UILabel *eventDateLabel;
@property (nonatomic,weak) IBOutlet UILabel *eventPriceLabel;
@property (nonatomic,weak) IBOutlet UIButton *buyButton;

@end