//
//  LoginResetPasswordViewController.h
//  MeiZan
//
//  Created by 林宇 on 2018/3/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginResetPasswordViewController : BaseViewController
- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber;
- (void)resetPasswordNewPassword:(NSString *)newPassword;
@end
