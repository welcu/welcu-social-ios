//
//  WelcuPostDraftCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/9/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuPostDraftCell.h"

#import <FontasticIcons/FontasticIcons.h>

#import "WelcuPostDraft.h"

@interface WelcuPostDraftCell () <WelcuPostDraftProgressDelegate>

@end

@implementation WelcuPostDraftCell

@synthesize postDraft = _postDraft;

- (void)setPostDraft:(WelcuPostDraft *)postDraft
{
    _postDraft = postDraft;
    
    postDraft.progressDelegate = self;
    self.progressView.progress = postDraft.progress;
    
    if (postDraft.photo) {
        self.photoImageView.image = [UIImage imageWithData:postDraft.photo];
    } else {
        self.photoImageView.image = [[FIFontAwesomeIcon quoteRightIcon] imageWithBounds:CGRectMake(0, 0, 30, 30)
                                                                                  color:[UIColor welcuMediumGrey]];
    }
}

#pragma mark - WelcuPostDraftProgressDelegate

- (void)postDraft:(WelcuPostDraft *)postDraft uploadProgressedTo:(CGFloat)progress
{
    self.progressView.progress = self.postDraft.progress;
    
    if (self.postDraft.progress == 1.0) {
        self.statusLabel.text = @"Finishing touches";
    }
}

@end
