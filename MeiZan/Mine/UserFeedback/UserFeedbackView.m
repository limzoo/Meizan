//
//  UserFeedbackView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/24.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UserFeedbackView.h"
#import "UserFeedbViewController.h"
@interface UserFeedbackView()<UITextViewDelegate>
@property (nonatomic, strong) FSTextView *textView;
@property (nonatomic, strong) UITextField *phoneNumber;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UILabel *letterNumberLabel;
@end
@implementation UserFeedbackView
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *const_labelView = [[UIView alloc] init];
    [self addSubview:const_labelView];
    [const_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *const_label = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x999999) text:@"请选择您的反馈问题类型（必选）"];
    [const_labelView addSubview:const_label];
    [const_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(const_labelView);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
    }];
    
    UIButton *button_1 = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:15 fontSize:14 title:@"投诉司机"];
    button_1.tag = 10;
    button_1.layer.borderWidth = 1;
    button_1.layer.borderColor = COLOR_RGB16(0xEDEDED).CGColor;
    [self addSubview:button_1];
    [button_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(const_labelView.mas_bottom).offset(20);
        make.width.mas_equalTo(CUSTOM_WIDTH(86));
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button_2 = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:15 fontSize:14 title:@"投诉客服"];
     button_2.tag = 11;
    button_2.layer.borderWidth = 1;
    button_2.layer.borderColor = COLOR_RGB16(0xEDEDED).CGColor;
    [self addSubview:button_2];
    [button_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(button_1.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.top.mas_equalTo(const_labelView.mas_bottom).offset(20);
        make.width.mas_equalTo(CUSTOM_WIDTH(86));
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button_3 = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:15 fontSize:14 title:@"商品问题"];
    button_3.tag = 12;
    button_3.layer.borderWidth = 1;
    button_3.layer.borderColor = COLOR_RGB16(0xEDEDED).CGColor;
    [self addSubview:button_3];
    [button_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(button_2.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.top.mas_equalTo(const_labelView.mas_bottom).offset(20);
        make.width.mas_equalTo(CUSTOM_WIDTH(86));
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button_4 = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:15 fontSize:14 title:@"新品需求"];
    button_4.tag = 13;
    button_4.layer.borderWidth = 1;
    button_4.layer.borderColor = COLOR_RGB16(0xEDEDED).CGColor;
    [self addSubview:button_4];
    [button_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(button_1);
        make.top.mas_equalTo(button_1.mas_bottom).offset(14);
        make.width.mas_equalTo(CUSTOM_WIDTH(86));
        make.height.mas_equalTo(30);
    }];
    
    UIButton *button_5 = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:15 fontSize:14 title:@"其他"];
    button_5.tag = 14;
    button_5.layer.borderWidth = 1;
    button_5.layer.borderColor = COLOR_RGB16(0xEDEDED).CGColor;
    [self addSubview:button_5];
    [button_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(button_4.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.top.mas_equalTo(button_1.mas_bottom).offset(14);
        make.width.mas_equalTo(CUSTOM_WIDTH(86));
        make.height.mas_equalTo(30);
    }];
    
    for (int i = 10; i < 15; i++) {
        UIButton *button = [self viewWithTag:i];
        [button addTarget:self action:@selector(changeState:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.textView = [[FSTextView alloc] init];
    self.textView.delegate = self;
    self.textView.placeholder = @"说点什么告诉美赞吧～（必填）";
    self.textView.maxLength = 50;
    self.textView.borderColor = COLOR_RGB16(0xededed);
    self.textView.borderWidth = 1;
    self.textView.placeholderColor = COLOR_RGB16(0x999999);
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(button_5.mas_bottom).offset(14);
        make.height.mas_equalTo(104);
    }];
    
    self.letterNumberLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"0/50"];
    self.letterNumberLabel.textAlignment = NSTextAlignmentRight;
    [self.textView addSubview:self.letterNumberLabel];
    [self.letterNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.mas_equalTo(self.textView).offset(-CUSTOM_WIDTH(10    ));
    }];
   
    [self.textView addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew || NSKeyValueChangeOldKey context:nil];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR_F5;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(8);
        make.top.mas_equalTo(self.textView.mas_bottom).offset(14);
    }];
    
    UILabel *const_phoneNumlabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"联系方式"];
    [self addSubview:const_phoneNumlabel];
    [const_phoneNumlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(lineView.mas_bottom).offset(17);
        make.height.mas_equalTo(15);
    }];
    
    self.phoneNumber = [[UITextField alloc] init];
    self.phoneNumber.placeholder = @"请输入您的联系方式";
    [self addSubview:self.phoneNumber];
    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(const_phoneNumlabel.mas_trailing).offset(10);
        make.trailing.mas_equalTo(self).offset(-14);
        make.centerY.mas_equalTo(const_phoneNumlabel);
    }];
    
    UIView *lineView_2 = [[UIView alloc] init];
    lineView_2.backgroundColor = INSETCOLOR;
    [self addSubview:lineView_2];
    [lineView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(const_phoneNumlabel.mas_bottom).offset(17);
        make.trailing.mas_equalTo(self);
    }];
    
    UIButton *confirmButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4 fontSize:16 title:@"提交反馈"];
    [confirmButton addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.bottom.mas_equalTo(self).offset(-15);
        make.height.mas_equalTo(44);
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"]) {
        self.letterNumberLabel.text = [NSString stringWithFormat:@"%ld/50",self.textView.text.length];
    }
}
- (void)send{
    [( (UserFeedbViewController *)self.myViewController) userFeedbackWithString:self.textView.text];
}
- (void)changeState:(UIButton *)sender{
    for (int i = 10; i < 15; i++) {
        UIButton *button = [self viewWithTag:i];
        if (sender.tag == i) {
            [button setTitleColor:STYLECOLOR forState:0];
            button.layer.borderColor = STYLECOLOR.CGColor;
        }else{
             [button setTitleColor:TEXTCOLOR forState:0];
            button.layer.borderColor = COLOR_RGB16(0xEDEDED).CGColor;
        }
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length > 0) {
        self.confirmButton.backgroundColor = STYLECOLOR;
    }
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (![Tool isPoint:point inFrame:self.textView.frame]) {
        [self endEditing:YES];
    }
    if (![Tool isPoint:point inFrame:self.phoneNumber.frame]) {
        [self endEditing:YES];
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
