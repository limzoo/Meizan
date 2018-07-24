//
//  UserLoginView.h
//  JingXuan
//
//  Created by sfs on 2017/12/21.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "LYSlideSelectBar.h"
@interface UserLoginView : BaseView
@property (nonatomic, strong) LYSlideSelectBar *selectBar;
@property (nonatomic, strong) UIButton *showPasswordButton;
@property (nonatomic, strong) UIButton *forgetPassword;
@property (nonatomic, strong) UIButton *getVerifyNum;

@property (nonatomic, strong) UITextField *phoneNumTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, assign) NSUInteger selectIndex;//0账号密码登录 1验证码登录

@end
