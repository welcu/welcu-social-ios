//
//  WelcuPostDraftCell.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/9/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WelcuPostDraft;

@interface WelcuPostDraftCell : UITableViewCell

@property (nonatomic,strong) WelcuPostDraft *postDraft;

@property (nonatomic,weak) IBOutlet UIProgressView *progressView;
@property (nonatomic,weak) IBOutlet UILabel *statusLabel;
@property (nonatomic,weak) IBOutlet UIButton *retryButton;
@property (nonatomic,weak) IBOutlet UIImageView *photoImageView;

@end
