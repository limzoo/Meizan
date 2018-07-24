//
//  WXLoginBindViewController.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseViewController.h"

@interface WXLoginBindViewController : BaseViewController
- (instancetype)initWithWxUnionId:(NSString *)wxUnionId wxOpenId:(NSString*)wxOpenId  nickName:(NSString*)nickName photoUrl:(NSString*)photoUrl;
- (void)bindActionWithMobileNo:(NSString *)mobileNo smsCode:(NSString*)smsCode;
- (void)getVerifyCode;
@end
