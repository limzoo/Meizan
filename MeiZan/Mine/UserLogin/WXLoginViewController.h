//
//  WXLoginViewController.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseViewController.h"

@interface WXLoginViewController : BaseViewController
- (instancetype)initWithAccess_token:(NSString *)access_token openid:(NSString *)openid unionId:(NSString *)unionId;
- (void)moveToBindPage;
@end
