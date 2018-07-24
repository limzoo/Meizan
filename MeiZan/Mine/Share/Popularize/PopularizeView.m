//
//  PopularizeView.m
//  MeiZan
//
//  Created by 林宇 on 2018/3/15.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "PopularizeView.h"
#import "PopularizeViewController.h"
@interface PopularizeView()
@property (nonatomic,strong) UITextField *userName;
@property (nonatomic,strong) UITextField *mobileNo;
@property (nonatomic,strong) UITextField *area;
@end
@implementation PopularizeView
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
    
    self.userName = [[UITextField alloc] init];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"意向客户姓名" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14],NSForegroundColorAttributeName:COLOR_RGB16(0x999999)}];
    self.userName.attributedPlaceholder = str;
    self.userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.userName];
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    self.mobileNo = [[UITextField alloc] init];
    NSAttributedString *str_2 = [[NSAttributedString alloc] initWithString:@"意向客户手机号码" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14],NSForegroundColorAttributeName:COLOR_RGB16(0x999999)}];
    self.mobileNo.attributedPlaceholder = str_2;
    self.mobileNo.keyboardType = UIKeyboardTypeNumberPad;
    self.mobileNo.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.mobileNo];
    [self.mobileNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(icon_2);
        make.leading.mas_equalTo(icon_2.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        make.height.mas_equalTo(20);
    }];
    
    
    UIImageView *icon_3 = [[UIImageView alloc] init];
    icon_3.contentMode = UIViewContentModeScaleAspectFill;
    icon_3.image = [UIImage imageNamed:@"password_unselect"];
    [self addSubview:icon_3];
    [icon_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(16);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(lineView_2.mas_bottom).offset(21);
    }];
    
    UIView *lineView_3 = [[UIView alloc] init];
    lineView_3.backgroundColor = INSETCOLOR;
    [self addSubview:lineView_3];
    [lineView_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(self);
        make.top.mas_equalTo(icon_3.mas_bottom).offset(15);
    }];
    
    self.area = [[UITextField alloc] init];
    NSAttributedString *str_3 = [[NSAttributedString alloc] initWithString:@"计划开店地区" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14],NSForegroundColorAttributeName:COLOR_RGB16(0x999999)}];
    self.area.attributedPlaceholder = str_3;
    self.area.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.area];
    [self.area mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(icon_3);
        make.leading.mas_equalTo(icon_3.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        make.height.mas_equalTo(20);
    }];
    
    
    UIButton *confirmButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4.0f fontSize:16 title:@"保存"];
    [self addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(uploadUserMessage) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(lineView_3.mas_bottom).offset(20);
    }];

}

- (void)uploadUserMessage{
    if (self.userName.text.length == 0 || self.userName.text.length == 0) {
        [Tool showMessage:@"姓名不能为空" duration:3];
        return;
    }
    if (self.mobileNo.text.length == 0 || self.mobileNo.text.length == 0) {
        [Tool showMessage:@"手机号码不能为空" duration:3];
        return;
    }
    if (self.area.text.length == 0 || self.area.text.length == 0) {
        [Tool showMessage:@"地区不能为空" duration:3];
        return;
    }
    [((PopularizeViewController *)self.myViewController) uploadPopularizationMsg:self.userName.text mobileNo:self.mobileNo.text area:self.area.text];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (![[super hitTest:point withEvent:event] isKindOfClass:[UITextField class]]) {
        [self resignFirstResponder];
    }
    return [super hitTest:point withEvent:event];
}

@end
