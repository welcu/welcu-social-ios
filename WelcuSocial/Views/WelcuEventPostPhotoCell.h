//
//  WelcuFeedPostPhotoCell.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/5/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcuEventPostCell.h"
#import <NPRImageView/NPRImageView.h>

@interface WelcuEventPostPhotoCell : UITableViewCell <WelcuEventPostCell>

@property (weak,nonatomic) IBOutlet NPRImageView *postPhotoView;

@end
