//
//  CommissionWithdraw.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "CommissionWithdraw.h"
#import "CommissionWithdrawViewController.h"
@interface CommissionWithdraw()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *ammount;
@property (nonatomic, strong) UIButton *nextStepButton;
@end
@implementation CommissionWithdraw
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *backGroundView = [[UIView alloc] init];
    backGroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backGroundView];
    [backGroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(14);
        make.height.mas_equalTo(144);
    }];
    
    UILabel *const_money = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"金额"];
    [backGroundView addSubview:const_money];
    [const_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(15);
    }];
    
    UILabel *const_yuan = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"SourceHanSans-Regular" size:20] color:TITLECOLOR text:@"¥"];
    [backGroundView addSubview:const_yuan];
    [const_yuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(const_money);
        make.top.mas_equalTo(const_money.mas_bottom).offset(33);
        make.width.mas_equalTo(20);
    }];
    
    self.ammount = [[UITextField alloc] init];
    self.ammount.keyboardType = UIKeyboardTypeNumberPad;
    self.ammount.delegate = self;
    self.ammount.placeholder = @"满1元可转出";
    [backGroundView addSubview:self.ammount];
    [self.ammount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(const_yuan);
        make.leading.mas_equalTo(const_yuan.mas_trailing).offset(10);
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        make.height.mas_equalTo(30);
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_RGB16(0xe5e5e5);
    [backGroundView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.height.mas_equalTo(1);
        make.trailing.mas_equalTo(self);
        make.top.mas_equalTo(const_yuan.mas_bottom).offset(18);
    }];
    
    UILabel *const_announece = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@"活动说明：佣金将直接转出到您的账户余额"];
    [backGroundView addSubview:const_announece];
    [const_announece mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(lineView.mas_bottom).offset(14);
    }];
    
    self.nextStepButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:COLOR_RGB16(0xd8d8d8) cornerRadius:4.0f fontSize:16 title:@"确定"];
    [self.nextStepButton addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.nextStepButton];
    [self.nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(backGroundView.mas_bottom).offset(20);
    }];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.nextStepButton.backgroundColor = STYLECOLOR;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.nextStepButton.backgroundColor = COLOR_RGB16(0xd8d8d8);
    return YES;
}

- (void)nextStepAction:(UIButton *)sender{
    [((CommissionWithdrawViewController *)self.myViewController) transferBrokerage:self.ammount.text.floatValue];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
