//
//  UserLoginView.m
//  JingXuan
//
//  Created by sfs on 2017/12/21.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "UserLoginView.h"
#import "UserRegisterViewController.h"
#import "UserLoginViewController.h"
#import "LoginForgetPasswordViewController.h"
#import "WXApi.h"
@interface UserLoginView()<LYSlideSelectBarDelegate, WXApiDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *phoneNumIMGV;
@property (nonatomic, strong) UIImageView *passwordIMGV;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, assign) NSInteger sec;
@property (nonatomic, strong) NSTimer *timer;
@end
@implementation UserLoginView
- (void)slideSelectBar:(LYSlideSelectBar *)slideSelectBar didSelectAnotherItemAtIndex:(NSUInteger)index{
    self.passwordTextField.text = nil;
    if (index == 0) {
        self.selectIndex = 0;
        [UIView animateWithDuration:0.7 animations:^{
            self.getVerifyNum.alpha = 0;
            self.forgetPassword.alpha = 1;
            self.showPasswordButton.alpha = 1;
            self.passwordTextField.secureTextEntry = YES;
        } completion:^(BOOL finished) {
            if (finished) {
                [self.getVerifyNum setHidden:YES];
                [self.forgetPassword setHidden:NO];
                [self.showPasswordButton setHidden:NO];
            }
        }];
    }else{
        self.selectIndex = 1;
        [UIView animateWithDuration:0.7 animations:^{
            self.getVerifyNum.alpha = 1;
            self.forgetPassword.alpha = 0;
            self.showPasswordButton.alpha = 0;
            self.passwordTextField.secureTextEntry = NO;
        }completion:^(BOOL finished) {
            if (finished) {
                [self.getVerifyNum setHidden:NO];
                [self.forgetPassword setHidden:YES];
                [self.showPasswordButton setHidden:YES];
            }
        }];
    }
}

- (void)configInitial{
    self.selectIndex = 0;
}

- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    self.selectBar = [[LYSlideSelectBar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44) itemNum:2 slideViewBounds:CGSizeMake(114, 2)];
    self.selectBar.delegate = self;
    self.selectBar.titles = @[@"账号登录",@"短信验证码登录"];
    self.selectBar.titlesFont = @[[UIFont fontWithName:@"PingFangSC-Regular" size:16],[UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    [self.selectBar setItemTinColor:TITLECOLOR defaultColor:TEXTCOLOR];
    [self.selectBar setSlideViewTinColor:STYLECOLOR];
    [self addSubview:self.selectBar];
    
    UIView *inset_lineView = [[UIView alloc] init];
    inset_lineView.backgroundColor = INSETCOLOR_F5;
    [self addSubview:inset_lineView];
    [inset_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(self.selectBar.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
    }];
    
    UIView *phoneNumView = [[UIView alloc] init];
    [self addSubview:phoneNumView];
    [phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.leading.mas_equalTo(self);
        make.height.mas_equalTo(58);
        make.top.mas_equalTo(inset_lineView.mas_bottom);
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
    self.phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入手机号码" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:14]}];
    self.phoneNumTextField.delegate = self;
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
         make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
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
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(self);
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
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTextField.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"请输入登录密码" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:14]}];
    [passwordView addSubview:self.passwordTextField];
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.passwordIMGV.mas_trailing).offset(CUSTOM_WIDTH(16));
        make.width.mas_equalTo(200);
        make.centerY.mas_equalTo(passwordView);
    }];
    
    self.getVerifyNum = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:2 fontSize:14 title:@"获取验证码"];
    [self.getVerifyNum addTarget:self action:@selector(getVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    self.getVerifyNum.hidden = YES;
    [passwordView addSubview:self.getVerifyNum];
    [self.getVerifyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(100));
        make.height.mas_equalTo(32);
        make.centerY.mas_equalTo(passwordView);
        make.trailing.mas_equalTo(self).mas_equalTo(-CUSTOM_WIDTH(14));
    }];
    
    self.forgetPassword = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0x999999) backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@"忘记密码?"];
    [self.forgetPassword addTarget:self action:@selector(moveToForgetPasswordPage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.forgetPassword];
    [self.forgetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        make.top.mas_equalTo(passwordView.mas_bottom).offset(20);
    }];
    
    self.loginButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:COLOR_RGB16(0xd8d8d8) cornerRadius:4.0f fontSize:16 title:@"登录"];
    [self.loginButton addTarget:self.myViewController action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.forgetPassword.mas_bottom).offset(20);
    }];
    
    UILabel *const_other = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@"其他登录方式"];
    [self addSubview:const_other];
    [const_other mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.loginButton.mas_bottom).offset(30);
    }];
    
    UIView *leftLineView = [[UIView alloc] init];
    leftLineView.backgroundColor = COLOR_RGB16(0xdfdfdf);
    [self addSubview:leftLineView];
    [leftLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(16));
        make.trailing.mas_equalTo(const_other.mas_leading).offset(-CUSTOM_WIDTH(10));
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(const_other);
    }];
    
    UIView *rightLineView = [[UIView alloc] init];
    rightLineView.backgroundColor = COLOR_RGB16(0xdfdfdf);
    [self addSubview:rightLineView];
    [rightLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(16));
        make.leading.mas_equalTo(const_other.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.height.mas_equalTo(1);
        make.centerY.mas_equalTo(const_other);
    }];
    
    UIButton *weixinLogin = [UIButton initCustomTypeButtonWithTextColor:nil backGroudColor:nil cornerRadius:0 fontSize:0 title:nil];
    [weixinLogin setImage:[UIImage imageNamed:@"微信登录"] forState:UIControlStateNormal];
    [weixinLogin addTarget:self action:@selector(WXLogin) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:weixinLogin];
    [weixinLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(const_other.mas_bottom).offset(30);
    }];
    
    UILabel *const_wxLogin = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@"微信登录"];
    [self addSubview:const_wxLogin];
    [const_wxLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weixinLogin);
        make.top.mas_equalTo(weixinLogin.mas_bottom).offset(10);
    }];
    if (![WXApi isWXAppInstalled]) {
        const_other.hidden= YES;
        leftLineView.hidden = YES;
        rightLineView.hidden = YES;
        weixinLogin.hidden = YES;
        const_wxLogin.hidden = YES;
    }
    
 
    
    UIButton *moveToHomePage = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0x999999) backGroudColor:[UIColor whiteColor] cornerRadius:4 fontSize:16 title:@"去商城主页"];
    moveToHomePage.layer.borderColor = COLOR_RGB16(0x999999).CGColor;
//    [mobileFastRegister addTarget:self action:@selector(moveToRegisterPage) forControlEvents:UIControlEventTouchUpInside];
     [moveToHomePage addTarget:self action:@selector(popToHomePage) forControlEvents:UIControlEventTouchUpInside];
    moveToHomePage.layer.borderWidth = 1;
    [self addSubview:moveToHomePage];
    [moveToHomePage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(const_wxLogin.mas_bottom).offset(90);
    }];
    
    UIButton *mobileFastRegister = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0x999999) backGroudColor:[UIColor whiteColor] cornerRadius:4 fontSize:16 title:@"注册"];
    mobileFastRegister.hidden = YES;
    mobileFastRegister.layer.borderColor = COLOR_RGB16(0x999999).CGColor;
        [mobileFastRegister addTarget:self action:@selector(moveToRegisterPage) forControlEvents:UIControlEventTouchUpInside];
//    [mobileFastRegister addTarget:self action:@selector(popToHomePage) forControlEvents:UIControlEventTouchUpInside];
    mobileFastRegister.layer.borderWidth = 1;
    [self addSubview:mobileFastRegister];
    [mobileFastRegister mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(moveToHomePage.mas_top).offset(-30);
    }];
}
- (void)popToHomePage{
    [self.myViewController.navigationController popViewControllerAnimated:YES];
}

- (void)moveToForgetPasswordPage{
    //先发送验证码
    if (![Tool isValidateMobile:self.phoneNumTextField.text]) {
        [Tool showMessage:@"请输入手机号码" duration:3];
        return;
    }
    [((UserLoginViewController *)self.myViewController) getVerifyCodeMoveToPage:YES];
}

- (void)WXLogin{
    //构造SendAuthReq结构体
    SendAuthReq* req = [[SendAuthReq alloc ] init ];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"123" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
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
        self.loginButton.backgroundColor = STYLECOLOR;
    }else{
         self.loginButton.backgroundColor = COLOR_RGB16(0xd8d8d8);
    }
    return YES;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (![Tool isPoint:point inFrame:self.phoneNumTextField.frame]&&![Tool isPoint:point inFrame:self.passwordTextField.frame]) {
        [self endEditing:YES];
    }
    return [super hitTest:point withEvent:event];
}

- (void)moveToRegisterPage{
    UserRegisterViewController *vc  = [[UserRegisterViewController alloc] init];
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}

- (void)getVerifyCode:(UIButton *)sender{
    if (![Tool isValidateMobile:self.phoneNumTextField.text]) {
        [Tool showMessage:@"请输入正确手机号码" duration:3];
        return;
    }
    [((UserLoginViewController *)self.myViewController) getVerifyCodeMoveToPage:NO];
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
@end
