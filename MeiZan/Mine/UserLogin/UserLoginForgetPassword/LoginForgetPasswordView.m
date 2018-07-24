//
//  LoginForgetPasswordView.m
//  MeiZan
//
//  Created by 林宇 on 2018/3/7.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "LoginForgetPasswordView.h"
#import "LoginForgetPasswordViewController.h"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface LoginForgetPasswordView()<UITextFieldDelegate>

//用来装密码圆点的数组
@property (nonatomic,strong) NSMutableArray *passwordDotsArray;
@property (nonatomic,strong) UITextField *passwordField;
@property (nonatomic, strong) UIView *hideTextFieldView;//遮住输入框;
@property (nonatomic, strong) UIButton *resendButton;

@end
@implementation LoginForgetPasswordView
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    self.annouceLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@".PingFangSC-Regular" size:16] color:TITLECOLOR text:@"验证码已发送到手机\n"];
    self.annouceLabel.textAlignment = NSTextAlignmentCenter;
    self.annouceLabel.numberOfLines = 2;
    [self addSubview:self.annouceLabel];
    [self.annouceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(CUSTOM_HEIGHT(56));
    }];
    
    self.passwordField = [[UITextField alloc] init];
    self.passwordField.delegate = (id)self;
    [self addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(132);
        make.top.mas_equalTo(self.annouceLabel.mas_bottom).offset(45);
    }];
    
    self.hideTextFieldView = [[UIView alloc] init];
    self.hideTextFieldView.userInteractionEnabled = YES;
    self.hideTextFieldView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.hideTextFieldView];
    [self bringSubviewToFront:self.hideTextFieldView];
    [self.hideTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.bottom.mas_equalTo(_passwordField);
    }];
    
    
    for (int i = 0; i < 6; i++) {
        UILabel *letterLabel = [UILabel initWithSystemFontOfSize:16 color:TITLECOLOR text:@""];
        [letterLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(focusTextField)]];
        letterLabel.textAlignment = NSTextAlignmentCenter;
        letterLabel.userInteractionEnabled = YES;
        letterLabel.tag = 100 +i;
        [self.hideTextFieldView addSubview:letterLabel];
        if (i == 0) {
            [letterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(self.hideTextFieldView);
                make.width.mas_equalTo(self.hideTextFieldView).multipliedBy(1/6.0);
                make.leading.mas_equalTo(self.hideTextFieldView.mas_leading);
            }];
        }else{
            UILabel *leftLabel = [self viewWithTag:i - 1 + 100];
            [letterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(self.hideTextFieldView);
                make.width.mas_equalTo(self.hideTextFieldView).multipliedBy(1/6.0);
                make.leading.mas_equalTo(leftLabel.mas_trailing);
            }];
        }
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = TITLECOLOR;
        lineView.layer.cornerRadius = 1;
        lineView.layer.masksToBounds = YES;
        [letterLabel addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.bottom.mas_equalTo(letterLabel);
            make.height.mas_equalTo(2);
            make.width.mas_equalTo(letterLabel).multipliedBy(4/5.0);
        }];
    }
    
    _passwordField.keyboardType = UIKeyboardTypeNumberPad;
    [_passwordField addTarget:self action:@selector(passwordFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    self.resendButton = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0x49902e) backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:12 title:@"点击重新获取"];
    [self addSubview:self.resendButton];
    [self.resendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.passwordField.mas_bottom).offset(CUSTOM_HEIGHT(12));
    }];
    
    UILabel *constLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@"若无法受到验证码，请拨打客服电话：\n400-961-2016"];
    constLabel.textAlignment = NSTextAlignmentCenter;
    constLabel.numberOfLines = 2;
    [self addSubview:constLabel];
    [constLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.resendButton.mas_bottom).offset(CUSTOM_HEIGHT(32));
    }];
}
- (void)focusTextField{
    [self.passwordField becomeFirstResponder];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
        return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField.text.length == 6 && string.length > 0 ) {
        return NO;
    }
    return YES;
}
- (void)passwordFieldDidChange:(UITextField *)textField{
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < 6; i++) {
            if (i < textField.text.length) {
                UILabel *letterLabel = [self viewWithTag:i + 100];
                letterLabel.text = [textField.text substringWithRange:NSMakeRange(i, 1)];
            }else{
                UILabel *letterLabel = [self viewWithTag:i + 100];
                letterLabel.text = @"";
            }
        };
    });
    if (textField.text.length == 6) {
        [((LoginForgetPasswordViewController *)self.myViewController) verifyUserCode:self.passwordField.text];
    }
}


@end
