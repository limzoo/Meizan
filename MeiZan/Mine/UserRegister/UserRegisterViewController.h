//
//  UserRegisterViewController.h
//  JingXuan
//
//  Created by sfs on 2017/12/22.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseViewController.h"

@interface UserRegisterViewController : BaseViewController
- (void)registerActionWithMobileNo:(NSString *)mobileNo smsCode:(NSString *)smsCode inviteCode:(NSString *)inviteCode password:(NSString *)password nickName:(NSString *)nickName;
- (void)getVerifyCodeWithPhoneNum:(NSString *)phoneNo;
@end
