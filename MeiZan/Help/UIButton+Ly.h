//
//  UIButton+Ly.h
//  OilLife
//
//  Created by sfs on 2017/10/27.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Ly)
+ (UIButton *)initSystemTypeButtonWithTextColor:(UIColor *)textColor backGroudColor:(UIColor *)backColor cornerRadius:(CGFloat)radius title:(NSString *)title;
+ (UIButton *)initCustomTypeButtonWithTextColor:(UIColor *)textColor backGroudColor:(UIColor *)backColor cornerRadius:(CGFloat)radius fontSize:(CGFloat)fontSize title:(NSString *)title;
@end
