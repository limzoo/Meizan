//
//  WXLoginBindView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "WXLoginBindView.h"
#import "WXLoginBindViewController.h"
@interface WXLoginBindView()<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *phoneNumIMGV;
@property (nonatomic, strong) UIImageView *passwordIMGV;
@property (nonatomic, strong) UIButton *bindButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger sec;
@end
@implementation WXLoginBindView
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *phoneNumView = [[UIView alloc] init];
    [self addSubview:phoneNumView];
    [phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.mas_equalTo(self);
        make.height.mas_equalTo(58);
        make.top.mas_equalTo(self).offset(49);
    }];
    
    self.phoneNumIMGV = [[UIImageView alloc] init];
    self.phoneNumIMGV.contentMode = UIViewContentModeCenter;
    self.phoneNumIMGV.image = [UIImage imageNamed:@"mobile_unselect"];
    [phoneNumView addSubview:self.phoneNumIMGV];
    [self.phoneNumIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(16));
        make.centerY.mas_equalTo(phoneNumView);
    }];
    
    self.phoneNumTextField = [[UITextField alloc] init];
    self.phoneNumTextField.delegate = self;
    self.phoneNumTextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号码" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:14]}];
    [phoneNumView addSubview: self.phoneNumTextField];
    [self.phoneNumTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.phoneNumIMGV.mas_trailing).offset(CUSTOM_WIDTH(16));
        make.trailing.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(phoneNumView);
    }];
    
    UIView *inset_lineView1 = [[UIView alloc] init];
    inset_lineView1.backgroundColor = INSETCOLOR_F5;
    [self addSubview:inset_lineView1];
    [inset_lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(phoneNumView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UIView *passwordView = [[UIView alloc] init];
    [self addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.mas_equalTo(self);
        make.height.mas_equalTo(58);
        make.top.mas_equalTo(inset_lineView1.mas_bottom);
    }];
    
    UIView *inset_lineView2 = [[UIView alloc] init];
    inset_lineView2.backgroundColor = INSETCOLOR_F5;
    [self addSubview:inset_lineView2];
    [inset_lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(passwordView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.passwordIMGV = [[UIImageView alloc] init];
    self.passwordIMGV.image = [UIImage imageNamed:@"password_unselect"];
    [passwordView addSubview:self.passwordIMGV];
    [self.passwordIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(16));
        make.centerY.mas_equalTo(passwordView);
    }];
    self.passwordTextField = [[UITextField alloc] init];
    self.passwordTextField.delegate = self;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入登录密码" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:14]}];
    [passwordView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.passwordIMGV.mas_trailing).offset(CUSTOM_WIDTH(16));
        make.width.mas_equalTo(200);
        make.centerY.mas_equalTo(passwordView);
    }];
    
    self.getVerifyNum = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:2 fontSize:14 title:@"获取验证码"];
    [self.getVerifyNum addTarget:self.myViewController action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    [passwordView addSubview:self.getVerifyNum];
    [self.getVerifyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(100));
        make.height.mas_equalTo(32);
        make.centerY.mas_equalTo(passwordView);
        make.trailing.mas_equalTo(self).mas_equalTo(-CUSTOM_WIDTH(14));
    }];

    self.bindButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:COLOR_RGB16(0xd8d8d8) cornerRadius:4 fontSize:16 title:@"确定"];
    [self addSubview:self.bindButton];
    [self.bindButton addTarget:self action:@selector(bindAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.bindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inset_lineView2).offset(36);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
    }];
}

- (void)bindAction:(UIButton *)sender{
    [((WXLoginBindViewController *)self.myViewController) bindActionWithMobileNo:self.phoneNumTextField.text smsCode:self.passwordTextField.text];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.phoneNumTextField) {
        if(string.length > 0){
            self.phoneNumIMGV.image = [UIImage imageNamed:@"mobile_select"];
        }else if(string.length == 0 && textField.text.length == 1){
            self.phoneNumIMGV.image = [UIImage imageNamed:@"mobile_unselect"];
        }
    }
    if (textField == self.passwordTextField) {
        if(string.length > 0){
            self.passwordIMGV.image = [UIImage imageNamed:@"password_select"];
        }else if(string.length == 0 && textField.text.length == 1){
            self.passwordIMGV.image = [UIImage imageNamed:@"password_unselect"];
        }
    }
    if (self.passwordTextField.text.length > 2 && self.phoneNumTextField.text.length > 2) {
        self.bindButton.backgroundColor = STYLECOLOR;
    }else{
        self.bindButton.backgroundColor = COLOR_RGB16(0xd8d8d8);
    }
    return YES;
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (![Tool isPoint:point inFrame:self.phoneNumTextField.frame]) {
        [self.phoneNumTextField resignFirstResponder];
    }
    if (![Tool isPoint:point inFrame:self.passwordTextField.frame]) {
        [self.passwordTextField resignFirstResponder];
    }
    return [super hitTest:point withEvent:event];
}

- (void)getVerifyCode:(UIButton *)sender{
    [((WXLoginBindViewController *)self.myViewController) getVerifyCode];
    self.sec = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
}

- (void)timeAction{
    self.sec ++;
    self.getVerifyNum.userInteractionEnabled = NO;
    [self.getVerifyNum setBackgroundColor:COLOR_RGB16(0xd8d8d8)];
    [self.getVerifyNum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.getVerifyNum setTitle:[NSString stringWithFormat:@"%ld秒",60 -self.sec] forState:UIControlStateNormal];
    if (self.sec == 60 - 1) {
        self.getVerifyNum.userInteractionEnabled = YES;
        self.getVerifyNum.backgroundColor = STYLECOLOR;
        [self.getVerifyNum setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
    }
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
