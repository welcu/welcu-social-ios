//
//  WelcuFeedPostHeaderView.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcuEventPostCell.h"

@interface WelcuEventPostHeaderView : UITableViewHeaderFooterView <WelcuEventPostCell>

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *userImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *userNameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *postDateLabel;

@end
