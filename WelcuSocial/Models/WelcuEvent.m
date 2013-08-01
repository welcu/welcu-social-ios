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
@dynamic eventID;
@dynamic startsAt;
@dynamic endsAt;
@dynamic headerPhoto;
@dynamic flyerURLString;
@dynamic flyerHeight;
@dynamic flyerWidth;
@dynamic posts;
@dynamic tickets;
@dynamic activities;
@dynamic accessedAt;
@dynamic venueName;
@dynamic venueAddress;
@dynamic basePriceCurrency;
@dynamic basePriceValue;

- (NSString *)formattedBasePrice
{
    if ([self.basePriceCurrency isEqualToString:@"free"]) {
        return @"free";
    } else if (self.basePriceValue && self.basePriceCurrency) {
        return [NSString stringWithFormat:@"$ %.2f %@", [self.basePriceValue floatValue], self.basePriceCurrency];
    } else {
        return nil;
    }
}

- (NSURL *)flyerURL
{
    if (self.flyerURLString) {
        return [NSURL URLWithString:self.flyerURLString];
    } else {
        return nil;
    }
}


- (NSURL *)headerPhotoURL
{
    if (self.headerPhoto) {
        return [NSURL URLWithString:self.headerPhoto];
    } else {
        return nil;
    }
}

- (void)accessed
{
    [self.managedObjectContext performBlock:^{
        self.accessedAt = [NSDate date];
        [self.managedObjectContext save:nil];
    }];
}

- (NSString *)formattedDateRange
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
