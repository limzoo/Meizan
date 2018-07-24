//
//  ForgetPasswordView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/10.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ForgetPasswordView.h"
@interface ForgetPasswordView()
@property (nonatomic, strong) UILabel *phoneNumer;
@end
@implementation ForgetPasswordView
- (void)createSubview{
    UILabel *const_Label = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:16] color:TITLECOLOR text:@"验证码已发送到手机"];
    const_Label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:const_Label];
    [const_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(56);
    }];
    
    self.phoneNumer = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:16] color:TITLECOLOR text:nil];
    const_Label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.phoneNumer];
    [self.phoneNumer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(const_Label.mas_bottom).offset(10);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
