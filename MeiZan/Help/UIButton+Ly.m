//
//  UIButton+Ly.m
//  OilLife
//
//  Created by sfs on 2017/10/27.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "UIButton+Ly.h"

@implementation UIButton (Ly)
+ (UIButton *)initSystemTypeButtonWithTextColor:(UIColor *)textColor backGroudColor:(UIColor *)backColor cornerRadius:(CGFloat)radius title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.backgroundColor = backColor;
    button.layer.cornerRadius = radius;
    return button;
}

+ (UIButton *)initCustomTypeButtonWithTextColor:(UIColor *)textColor backGroudColor:(UIColor *)backColor cornerRadius:(CGFloat)radius fontSize:(CGFloat)fontSize title:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
      button.titleLabel.font = [UIFont fontWithName:@".PingFangSC-Regular" size:fontSize];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:textColor forState:UIControlStateNormal];
    button.backgroundColor = backColor;
    button.layer.cornerRadius = radius;
    return button;
}
@end
