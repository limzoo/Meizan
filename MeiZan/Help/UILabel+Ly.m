//
//  UILabel+Ly.m
//  OilLife
//
//  Created by sfs on 2017/10/27.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "UILabel+Ly.h"

@implementation UILabel (Ly)
+ (UILabel *)initWithSystemFontOfSize:(CGFloat)size  color:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:size];
    label.textColor = color;
    return label;
}
+ (UILabel *)initWithCustomFontOfSize:(UIFont *)font  color:(UIColor *)color text:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = font;
    label.textColor = color;
    return label;
}
@end
