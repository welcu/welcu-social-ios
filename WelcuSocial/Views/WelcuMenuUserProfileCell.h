//
//  WelcuMenuUserProfileCell.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/29/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WelcuMenuUserProfileCell;

@protocol WelcuMenuUserProfileCellDelegate <NSObject>

- (void)menuUserProfileCelldidSelectUserSettingsAction:(WelcuMenuUserProfileCell *)cell;

@end

@interface WelcuMenuUserProfileCell : UITableViewCell

@property (weak, nonatomic) id<WelcuMenuUserProfileCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

- (IBAction)userSettingsSelected:(id)sender;

@end
