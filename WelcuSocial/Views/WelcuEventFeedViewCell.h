//
//  WelcuEventFeedViewCell.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/28/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMAttributedHighlightLabel/AMAttributedHighlightLabel.h>

@interface WelcuEventFeedViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userPictureView;
@property (weak, nonatomic) IBOutlet UILabel *postDateLabel;
@property (weak, nonatomic) IBOutlet AMAttributedHighlightLabel *postContentLabel;

@end
