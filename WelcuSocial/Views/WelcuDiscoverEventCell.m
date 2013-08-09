//
//  WelcuDiscoverEventCell.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 7/26/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuDiscoverEventCell.h"

#import <FontasticIcons.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation WelcuDiscoverEventCell

@synthesize event = _event;

+ (CGFloat)flyerHeightForEvent:(WelcuEvent *)event
{
    if (event.flyerURL) {
        return [event.flyerHeight floatValue]*145/[event.flyerWidth floatValue];
    } else {
        return 0;
    }
}

+ (CGFloat)heightForEvent:(WelcuEvent *)event;
{
    return 120 + [self flyerHeightForEvent:event];
}

- (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *formatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterNoStyle];
        [formatter setTimeZone:[NSTimeZone defaultTimeZone]];
    });
    
    return formatter;
}

- (void)awakeFromNib
{
    self.eventNameLabel.font = [UIFont fontWithName:@"GothamBold" size:14];
    self.eventNameLabel.textColor = [UIColor welcuPurple];

    self.eventDateLabel.font = [UIFont fontWithName:@"GothamMedium" size:11];
    self.eventDateLabel.textColor = [UIColor welcuMediumGrey];
    
    self.eventPriceLabel.font = [UIFont fontWithName:@"GothamMedium" size:13];
    
    self.fromLabel.font = [UIFont fontWithName:@"GothamMedium" size:9];
    self.fromLabel.textColor = [UIColor welcuDarkGrey];
    
    self.buyButton.backgroundColor = [UIColor welcuGreen];
    self.buyButton.layer.cornerRadius = 2;
    
    FIIcon *icon = [FIFontAwesomeIcon plusIcon];
    
    FIIconLayer *layer = [FIIconLayer new];
    layer.icon = icon;
    layer.frame = CGRectMake(5, 5, 10, 10);
    layer.iconColor = [UIColor whiteColor];
    [self.buyButton.layer addSublayer:layer];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(taped:)];
    self.gestureRecognizers = @[tapRecognizer];
}

- (void)taped:(id)sender
{
    [self.delegate discoverEventCellWasSelected:self];
//    if (self.event.eventURL) {
//         [[UIApplication sharedApplication] openURL:self.event.eventURL];
//    }
}

- (void)setEvent:(WelcuEvent *)event
{
    _event = event;
    self.eventNameLabel.text = event.name;
    self.eventDateLabel.text = [[self dateFormatter] stringFromDate:event.startsAt];

    self.eventFlyerHeightConstraint.constant = [WelcuDiscoverEventCell flyerHeightForEvent:event];
    if (event.flyerURL) {
        [self.eventFlyerImage setImageWithURL:event.flyerURL placeholderImage:[UIImage imageNamed:@"DefaultEventHeader"]];
        
        [self.eventFlyerImage setImageWithURLRequest:[NSURLRequest requestWithURL:event.flyerURL]
                                    placeholderImage:[UIImage imageNamed:@"DefaultEventHeader"]
                                             success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
        {
            if ([self.event.flyerURL isEqual:request.URL]) {
                self.eventFlyerImage.image = image;
            }
            
        } failure:nil];
    } else {
        self.eventFlyerImage.image = [UIImage imageNamed:@"ClearPixel"];
    }
    
    if ([event.basePriceCurrency isEqualToString:@"free"]) {
        self.fromLabel.hidden = YES;
    } else {
        self.fromLabel.hidden = NO;
    }
    self.eventPriceLabel.text = event.formattedBasePrice;;
    
    
}

@end
