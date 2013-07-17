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

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.userNameLabel.text = [[WelcuAccount currentAccount] fullName];

    NSURLRequest *request = [NSURLRequest requestWithURL:[[WelcuAccount currentAccount] pictureURL]];

    [self.userProfileImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        self.userProfileImageView.image = [image maskWithImage:[UIImage imageNamed:@"UserPhotoMask"]];
    } failure:nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)userSettingsSelected:(id)sender {
}
@end
