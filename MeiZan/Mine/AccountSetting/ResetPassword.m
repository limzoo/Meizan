//
//  ResetPassword.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ResetPassword.h"
#import "ResetPasswordViewController.h"
@implementation ResetPassword
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.image = [UIImage imageNamed:@"password_unselect"];
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(16);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self).offset(36);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(self);
        make.top.mas_equalTo(icon.mas_bottom).offset(15);
    }];
    
    self.oldPassword = [[UITextField alloc] init];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"请输入原始密码" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14],NSForegroundColorAttributeName:COLOR_RGB16(0x999999)}];
     self.oldPassword.secureTextEntry = YES;
    self.oldPassword.attributedPlaceholder = str;
    self.oldPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.oldPassword];
    [self.oldPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(icon);
        make.leading.mas_equalTo(icon.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *icon_2 = [[UIImageView alloc] init];
    icon_2.contentMode = UIViewContentModeScaleAspectFill;
    icon_2.image = [UIImage imageNamed:@"password_unselect"];
    [self addSubview:icon_2];
    [icon_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(16);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(lineView.mas_bottom).offset(21);
    }];
    
    UIView *lineView_2 = [[UIView alloc] init];
    lineView_2.backgroundColor = INSETCOLOR;
    [self addSubview:lineView_2];
    [lineView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(self);
        make.top.mas_equalTo(icon_2.mas_bottom).offset(15);
    }];
    
    self.password = [[UITextField alloc] init];
    NSAttributedString *str_2 = [[NSAttributedString alloc] initWithString:@"请输入新的密码" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14],NSForegroundColorAttributeName:COLOR_RGB16(0x999999)}];
    self.password.secureTextEntry = YES;
    self.password.attributedPlaceholder = str_2;
    self.password.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.password];
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(icon_2);
        make.leading.mas_equalTo(icon_2.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        make.height.mas_equalTo(20);
    }];
    
    
    UIButton *confirmButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4.0f fontSize:16 title:@"保存"];
    [self addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(resetPassword) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(lineView_2.mas_bottom).offset(20);
    }];
    
    UILabel *announce = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@"密码格式应为6-16位数字，字符或符号，不允许有空格"];
    announce.textAlignment = NSTextAlignmentCenter;
    announce.numberOfLines = 0;
    [self addSubview:announce];
    [announce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(confirmButton.mas_bottom).offset(20);
        make.leading.mas_equalTo(self).offset(35);
    }];
}

- (void)resetPassword{
    if (self.oldPassword.text.length == 0 || self.password.text.length == 0) {
        [Tool showMessage:@"输入密码不能为空" duration:3];
        return;
    }
    [((ResetPasswordViewController *)self.myViewController) resetPasswordWithOldPassword:self.oldPassword.text newPassword:self.password.text];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (![[super hitTest:point withEvent:event] isKindOfClass:[UITextField class]]) {
        [self resignFirstResponder];
    }
    return [super hitTest:point withEvent:event];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end