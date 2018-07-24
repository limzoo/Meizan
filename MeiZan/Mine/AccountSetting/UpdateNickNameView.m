//
//  UpdateNickNameView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UpdateNickNameView.h"
#import "UpdateNickNameViewController.h"
@implementation UpdateNickNameView
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.contentMode = UIViewContentModeScaleAspectFill;
    icon.image = [UIImage imageNamed:@"nickname_select"];
    [self addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(16);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self).offset(36);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = STYLECOLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
         make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(self);
        make.top.mas_equalTo(icon.mas_bottom).offset(15);
    }];
    
    self.nickName = [[UITextField alloc] init];
    NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"请输入新的昵称" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14],NSForegroundColorAttributeName:COLOR_RGB16(0x999999)}];
    self.nickName.attributedPlaceholder = str;
    self.nickName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.nickName];
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(icon);
        make.leading.mas_equalTo(icon.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        make.height.mas_equalTo(20);
    }];
    
    UIButton *confirmButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4.0f fontSize:16 title:@"保存"];
    [self addSubview:confirmButton];
    [confirmButton addTarget:self action:@selector(saveNickName) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(lineView.mas_bottom).offset(20);
    }];
}

- (void)saveNickName{
    [((UpdateNickNameViewController *)self.myViewController) saveNickname:self.nickName.text];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (![[super hitTest:point withEvent:event] isKindOfClass:[UITextField class]]) {
        [self resignFirstResponder];
    }
    return [super hitTest:point withEvent:event];
}
/*
 // Only override drawRect: if you perform custom drawing
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
