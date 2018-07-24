//
//  InputPasswordView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/26.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "GLTextField.h"
@interface InputPasswordView : BaseView
//密码输入文本框
@property (nonatomic,strong) GLTextField *passwordField;
@property (nonatomic,strong)  UIButton *cancelButton;
@property (nonatomic, strong) UIButton *forgetButton;
@property (nonatomic,copy) void (^verifyPayPassword)(NSString *password);
- (void)cleanPassword;
@end
