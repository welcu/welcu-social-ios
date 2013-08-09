//
//  WelcuFooterView.m
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/9/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import "WelcuFooterView.h"
#import "WelcuIcon.h"

@implementation WelcuFooterView

+ (WelcuFooterView *)footerWithFrame:(CGRect)frame color:(UIColor *)color text:(NSString *)text
{
    WelcuFooterView *view = [[[UINib nibWithNibName:@"WelcuFooterView" bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
    
    view.frame = frame;
    
    view.isotypeView.icon = [WelcuIcon welcuIsotypeIcon];
    view.isotypeView.iconColor = color;
    
    view.labelView.text = text;
    view.labelView.textColor = color;
    
    return view;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
