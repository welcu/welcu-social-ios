//
//  WelcuMenuActionCell.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/23/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WelcuMenuActionCellMyEventsType,
    WelcuMenuActionCellMyTicketsType,
    WelcuMenuActionCellDiscoverType
    } WelcuMenuActionCellType;

@interface WelcuMenuActionCell : UITableViewCell

@property (nonatomic,weak) IBOutlet UILabel *menuLabel;
@property (nonatomic,weak) IBOutlet UIImageView *iconImageView;

@property (nonatomic,assign) WelcuMenuActionCellType cellType;

@end
