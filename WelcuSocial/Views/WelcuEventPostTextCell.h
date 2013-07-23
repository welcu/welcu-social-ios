//
//  WelcuFeedPostTextCell.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcuEventPostCell.h"
#import <AMAttributedHighlightLabel/AMAttributedHighlightLabel.h>

@interface WelcuEventPostTextCell : UITableViewCell <WelcuEventPostCell>

@property (weak, nonatomic) IBOutlet UILabel *postContentLabel;

@end
