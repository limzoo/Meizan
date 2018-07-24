//
//  UILabel+Ly.h
//  OilLife
//
//  Created by sfs on 2017/10/27.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Ly)
+ (UILabel *)initWithSystemFontOfSize:(CGFloat)size  color:(UIColor *)color text:(NSString *)text;
+ (UILabel *)initWithCustomFontOfSize:(UIFont *)font  color:(UIColor *)color text:(NSString *)text;
@end
