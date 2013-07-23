//
//  WelcuMenuUserProfileCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 6/29/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuMenuUserProfileCell.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

#import "WelcuAccount.h"
#import "UIImage+MaskedImages.h"


@implementation WelcuMenuUserProfileCell

- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.userNameLabel.font = [UIFont fontWithName:@"MuseoSans-700" size:18];
    
    self.userNameLabel.text = [[WelcuAccount currentAccount] fullName];

    NSURLRequest *request = [NSURLRequest requestWithURL:[[WelcuAccount currentAccount] pictureURL]];

    [self.userProfileImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.userProfileImageView.image = [image maskWithImage:[UIImage imageNamed:@"UserPhotoMask"]];
    } failure:nil];
}

- (IBAction)userSettingsSelected:(id)sender {
}
@end
