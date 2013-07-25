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
@dynamic eventID;
@dynamic posts;
@dynamic tickets;
@dynamic activities;
@dynamic accessedAt;
@dynamic venueName;
@dynamic venueAddress;

- (NSURL *)headerPhotoURL
{
    if (self.headerPhoto) {
        return [NSURL URLWithString:self.headerPhoto];
    }
    
    return nil;
}

- (void)accessed
{
    [self.managedObjectContext performBlock:^{
        self.accessedAt = [NSDate date];
        [self.managedObjectContext save:nil];
    }];
}

- (NSString *)fromDateToDateString
{
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    });
    
    NSString *from = [formatter stringFromDate:self.startsAt];
    NSString *to = [formatter stringFromDate:self.endsAt];
    
    if ([from isEqualToString:to]) {
        return from;
    }
    
    return [NSString stringWithFormat:@"%@ - %@", from, to];
}

@end
