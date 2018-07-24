//
//  UserRegisterView.m
//  JingXuan
//
//  Created by sfs on 2017/12/22.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "UserRegisterView.h"
#import "UserRegisterViewController.h"
//#import ""
@interface UserRegisterView()
@property (nonatomic, strong) UIButton *getVerifyCode;
@property (nonatomic, assign) BOOL isAgress;
@property (nonatomic, assign) NSInteger sec;
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation UserRegisterView
- (void)configInitial{
    self.isAgress = NO;
}

- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *inviteNoView =  [[UIView alloc] init];
    [self addSubview:inviteNoView];
    [inviteNoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self);
        make.height.mas_equalTo(58);
    }];
    
    UIImageView *inviteNoIMGV = [[UIImageView alloc] init];
    inviteNoIMGV.image = [UIImage imageNamed:@"mobile_unselect"];
    inviteNoIMGV.contentMode = UIViewContentModeCenter;
    [inviteNoView addSubview:inviteNoIMGV];
    [inviteNoIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.leading.mas_equalTo(self).offset(16);
        make.centerY.mas_equalTo(inviteNoView);
    }];
    
    self.inviteNo = [[UITextField alloc] init];
    self.inviteNo.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入注册邀请码" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14],NSForegroundColorAttributeName:COLOR_RGB16(0x999999)}];
    [inviteNoView addSubview:self.inviteNo];
    [self.inviteNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(inviteNoIMGV.mas_trailing).offset(CUSTOM_WIDTH(15));
        make.centerY.mas_equalTo(inviteNoIMGV);
        make.trailing.mas_equalTo(inviteNoView).offset(-CUSTOM_WIDTH(14));
    }];
    
    UIView *inset_lineView_5 = [[UIView alloc] init];
    inset_lineView_5.backgroundColor = INSETCOLOR_F5;
    [self addSubview:inset_lineView_5];
    [inset_lineView_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(inviteNoView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    
    UIView *phoneNumView = [[UIView alloc] init];
    [self addSubview:phoneNumView];
    [phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(58);
        make.top.mas_equalTo(inset_lineView_5.mas_bottom);
    }];
    
    UIImageView *phoneNumIMGV = [[UIImageView alloc] init];
    phoneNumIMGV.image = [UIImage imageNamed:@"mobile_unselect"];
    phoneNumIMGV.contentMode = UIViewContentModeCenter;
    [phoneNumView addSubview:phoneNumIMGV];
    [phoneNumIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.leading.mas_equalTo(self).offset(16);
        make.centerY.mas_equalTo(phoneNumView);
    }];
    
    self.phoneNumber = [[UITextField alloc] init];
    self.phoneNumber.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号码" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14],NSForegroundColorAttributeName:COLOR_RGB16(0x999999)}];
    [phoneNumView addSubview:self.phoneNumber];
    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(phoneNumIMGV.mas_trailing).offset(CUSTOM_WIDTH(15));
        make.centerY.mas_equalTo(phoneNumIMGV);
        make.trailing.mas_equalTo(phoneNumView).offset(-CUSTOM_WIDTH(14));
    }];
    
    UIView *inset_lineView = [[UIView alloc] init];
    inset_lineView.backgroundColor = INSETCOLOR_F5;
    [self addSubview:inset_lineView];
    [inset_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(phoneNumView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UIView *verifyNumView = [[UIView alloc] init];
    [self addSubview:verifyNumView];
    [verifyNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(inset_lineView.mas_bottom);
        make.height.mas_equalTo(58);
    }];
    
    UIImageView *verifyNumIMGV = [[UIImageView alloc] init];
    verifyNumIMGV.image = [UIImage imageNamed:@"verifyCode_unselect"];
    [verifyNumView addSubview:verifyNumIMGV];
    [verifyNumIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.leading.mas_equalTo(self).offset(16);
        make.centerY.mas_equalTo(verifyNumView);
    }];
    
    self.getVerifyCode = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:2 fontSize:14 title:@"获取验证码"];
     [self.getVerifyCode addTarget:self action:@selector(getVerifyCodeAction) forControlEvents:UIControlEventTouchUpInside];
    [verifyNumView addSubview:self.getVerifyCode];
    [self.getVerifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(verifyNumView);
        make.width.mas_equalTo(CUSTOM_WIDTH(100));
        make.height.mas_equalTo(32);
    }];
    
    self.verifyCode = [[UITextField alloc] init];
     self.verifyCode.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入短信验证码" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14],NSForegroundColorAttributeName:COLOR_RGB16(0x999999)}];
    [verifyNumView addSubview:self.verifyCode];
    [self.verifyCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(verifyNumIMGV.mas_trailing).offset(CUSTOM_WIDTH(15));
        make.centerY.mas_equalTo(verifyNumIMGV);
        make.trailing.mas_equalTo(self.getVerifyCode.mas_leading).offset(-CUSTOM_WIDTH(20));
    }];
    
    UIView *inset_lineView1 = [[UIView alloc] init];
    inset_lineView1.backgroundColor = INSETCOLOR_F5;
    [self addSubview:inset_lineView1];
    [inset_lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(verifyNumView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UIView *nickNameView = [[UIView alloc] init];
    [self addSubview:nickNameView];
    [nickNameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(inset_lineView1.mas_bottom);
        make.height.mas_equalTo(58);
    }];
    
    UIImageView *nickNameIMGV = [[UIImageView alloc] init];
    nickNameIMGV.image = [UIImage imageNamed:@"nickname_unselect"];
    [nickNameView addSubview:nickNameIMGV];
    [nickNameIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.leading.mas_equalTo(self).offset(16);
        make.centerY.mas_equalTo(nickNameView);
    }];
    
    self.nickName = [[UITextField alloc] init];
    self.nickName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入15个字符以内昵称" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14],NSForegroundColorAttributeName:COLOR_RGB16(0x999999)}];
    [nickNameView addSubview:self.nickName];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(nickNameIMGV.mas_trailing).offset(CUSTOM_WIDTH(15));
        make.centerY.mas_equalTo(nickNameIMGV);
        make.trailing.mas_equalTo(nickNameView).offset(-CUSTOM_WIDTH(20));
    }];
    
    UIView *inset_lineView2 = [[UIView alloc] init];
    inset_lineView2.backgroundColor = INSETCOLOR_F5;
    [self addSubview:inset_lineView2];
    [inset_lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(nickNameView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UIView *passwordView = [[UIView alloc] init];
    [self addSubview:passwordView];
    [passwordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(inset_lineView2.mas_bottom);
        make.height.mas_equalTo(58);
    }];
    
    UIImageView *passwordIMGV = [[UIImageView alloc] init];
    passwordIMGV.image = [UIImage imageNamed:@"password_unselect"];
    [passwordView addSubview:passwordIMGV];
    [passwordIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
        make.leading.mas_equalTo(self).offset(16);
        make.centerY.mas_equalTo(passwordView);
    }];
    
    self.password = [[UITextField alloc] init];
    self.password.secureTextEntry = YES;
    self.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入6-20位数字或字母" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14], NSForegroundColorAttributeName:COLOR_RGB16(0x999999)}];
    [passwordView addSubview:self.password];
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(passwordIMGV.mas_trailing).offset(CUSTOM_WIDTH(15));
        make.centerY.mas_equalTo(passwordIMGV);
        make.trailing.mas_equalTo(passwordView).offset(-CUSTOM_WIDTH(20));
    }];
    
    UIView *inset_lineView3 = [[UIView alloc] init];
    inset_lineView3.backgroundColor = INSETCOLOR_F5;
    [self addSubview:inset_lineView3];
    [inset_lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(passwordView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *selectImg = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectImg setImage:[UIImage imageNamed:@"nick_unselect"] forState:UIControlStateNormal];
    [selectImg addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:selectImg];
    [selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(inset_lineView3).offset(20);
    }];
    
    UILabel *const_announceLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@"我已阅读并同意"];
    
    [self addSubview:const_announceLabel];
    [const_announceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(selectImg.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.centerY.mas_equalTo(selectImg);
    }];
    
    UIButton *pageButton = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0x4989E2) backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:12 title:@"《服务协议》《隐私政策》"];
    [self addSubview:pageButton];
    [pageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(const_announceLabel.mas_trailing).offset(CUSTOM_WIDTH(6));
        make.centerY.mas_equalTo(const_announceLabel);
    }];
    
    UIButton *registerButton = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0xffffff) backGroudColor:STYLECOLOR cornerRadius:4 fontSize:16 title:@"注册"];
     [registerButton addTarget:self.myViewController action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(pageButton.mas_bottom).offset(23);
    }];
}

- (void)getVerifyCodeAction{
    if (self.phoneNumber.text.length == 0) {
        [Tool showMessage:@"请输入手机号码" duration:3];
        return;
    }
    if (![Tool isValidateMobile:self.phoneNumber.text]) {
        [Tool showMessage:@"请输入正确手机号码" duration:3];
        return;
    }

    [((UserRegisterViewController *)self.myViewController) getVerifyCodeWithPhoneNum:self.phoneNumber.text];
    self.sec = 0;
     self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
}

- (void)timeAction{
    self.sec ++;
    self.getVerifyCode.userInteractionEnabled = NO;
    [self.getVerifyCode setBackgroundColor:COLOR_RGB16(0xd8d8d8)];
    [self.getVerifyCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.getVerifyCode setTitle:[NSString stringWithFormat:@"%ld秒",60 -self.sec] forState:UIControlStateNormal];
    if (self.sec == 60 - 1) {
        self.getVerifyCode.userInteractionEnabled = YES;
        self.getVerifyCode.backgroundColor = STYLECOLOR;
        [self.getVerifyCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
    }
    
}
- (void)registerAction{
    if (self.phoneNumber.text.length == 0) {
        [Tool showMessage:@"请输入手机号码" duration:3];
        return;
    }
    if (![Tool isValidateMobile:self.phoneNumber.text]) {
        [Tool showMessage:@"请输入正确手机号码" duration:3];
        return;
    }
    if (self.inviteNo.text.length == 0) {
        [Tool showMessage:@"请输入注册邀请码" duration:3];
        return;
    }
    if (self.verifyCode.text.length == 0) {
        [Tool showMessage:@"请输入验证码" duration:3];
        return;
    }
    if (self.nickName.text.length == 0) {
        [Tool showMessage:@"请输入昵称" duration:3];
        return;
    }
    if (!(6 <= self.password.text.length)) {
        [Tool showMessage:@"请输入6位密码" duration:3];
        return;
    }
    if (!self.isAgress) {
        [Tool showMessage:@"请同意用户守则" duration:3];
        return;
    }
    [((UserRegisterViewController *)self.myViewController) registerActionWithMobileNo:self.phoneNumber.text smsCode:self.verifyCode.text inviteCode:self.inviteNo.text password:self.password.text nickName:self.nickName.text];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (![[super hitTest:point withEvent:event] isKindOfClass:[UITextField class]]) {
        [self endEditing:YES];
    }
    return [super hitTest:point withEvent:event];
}

- (void)agreeAction:(UIButton *)sender{
    self.isAgress = !self.isAgress;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.isAgress) {
            [sender setImage:[UIImage imageNamed:@"nick_select"] forState:UIControlStateNormal];
        }else{
            [sender setImage:[UIImage imageNamed:@"nick_unselect"] forState:UIControlStateNormal];
        }
    });

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
