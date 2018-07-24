//
//  LoginForgetPasswordViewController.h
//  MeiZan
//
//  Created by 林宇 on 2018/3/7.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginForgetPasswordViewController : BaseViewController
- (instancetype)initWithMobileNo:(NSString *)mobileNO;
- (void)verifyUserCode:(NSString *)code;
@end
