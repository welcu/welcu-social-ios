//
//  WelcuEvent.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/12/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuEvent.h"
#import "WelcuActivity.h"
#import "WelcuPost.h"
#import "WelcuTicket.h"


@implementation WelcuEvent

@dynamic name;
@dynamic headerPhoto;
@dynamic startsAt;
@dynamic endsAt;
@dynamic posts;
@dynamic tickets;
@dynamic activities;

- (NSURL *)headerPhotoURL
{
    if (self.headerPhoto) {
        return [NSURL URLWithString:self.headerPhoto];
    }
    
    return nil;
}

@end
