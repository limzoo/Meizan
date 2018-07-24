//
//  SelectNumView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/21.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "SelectNumView.h"
@interface SelectNumView()

@end

@implementation SelectNumView
- (void)createSubview{
    UIView *buttonView = [[UIView alloc] init];
    buttonView.layer.borderWidth = 1;
    buttonView.layer.cornerRadius = 2;
    buttonView.layer.borderColor = COLOR_RGB16(0x979797).CGColor;
    [self addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.mas_equalTo(self);
    }];
    
    UIButton *subButton = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:COLOR_RGB16(0xffffff) cornerRadius:0 fontSize:13 title:@"-"];
    [subButton addTarget:self action:@selector(subAction) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:subButton];
    [subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(42));
        make.leading.top.bottom.mas_equalTo(buttonView);
    }];
    
    UIButton *addButton = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:COLOR_RGB16(0xffffff) cornerRadius:0 fontSize:13 title:@"+"];
    [addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(42));
        make.trailing.top.bottom.mas_equalTo(buttonView);
    }];
    
    self.numTextField = [[UITextField alloc] init];
    self.numTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13];
    [self.numTextField addTarget:self action:@selector(textFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
    self.numTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.numTextField.textColor = TEXTCOLOR;
    self.numTextField.layer.borderColor = COLOR_RGB16(0x979797).CGColor;
    self.numTextField.layer.borderWidth = 1;
    self.numTextField.textAlignment = NSTextAlignmentCenter;
    [buttonView addSubview:self.numTextField];
    [self.numTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(subButton.mas_trailing);
        make.top.bottom.mas_equalTo(buttonView);
        make.trailing.mas_equalTo(addButton.mas_leading);
    }];
}
- (void)textFieldValueChange:(UITextField *)textField{
     self.changeSelectNum(textField.text.integerValue);
}
- (void)subAction{
    self.numTextField.text = [NSString stringWithFormat:@"%ld", self.numTextField.text.integerValue - 1 < 0 ? 0 : self.numTextField.text.integerValue - 1];
    self.changeSelectNum(self.numTextField.text.integerValue);
}

- (void)addAction{
    self.numTextField.text = [NSString stringWithFormat:@"%ld", self.numTextField.text.integerValue + 1];
    self.changeSelectNum(self.numTextField.text.integerValue);
}

@end
