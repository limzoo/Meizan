//
//  UserConfig.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/10.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "MerchantInfo.h"
@interface UserConfig : NSObject<NSCoding>
@property (nonatomic, strong) UserInfo *userInfo;
@property (nonatomic, strong) NSString *levelName;
@property (nonatomic, strong) MerchantInfo *merchantInfo;
@property (nonatomic, strong) NSString *isPayPassword;
+ (instancetype)shareInstance;
@end

