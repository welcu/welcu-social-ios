//
//  WelcuFooterView.h
//  WelcuSocial
//
//  Created by Seba Gamboa on 8/9/13.
//  Copyright (c) 2013 Welcu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FontasticIcons/FontasticIcons.h>

@interface WelcuFooterView : UIView

@property (nonatomic,weak) IBOutlet FIIconView *isotypeView;
@property (nonatomic,weak) IBOutlet UILabel *labelView;

+ (WelcuFooterView *)footerWithFrame:(CGRect)frame color:(UIColor *)color text:(NSString *)text;

@end
