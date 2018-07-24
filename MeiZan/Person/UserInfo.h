//
//  UserInfo.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>
@property (nonatomic, assign) long userId;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *userStatus;
@property (nonatomic, strong) NSString *authenticationStatus;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *lastModifyTime;
@property (nonatomic, strong) NSString *userType;
@property (nonatomic, strong) NSString *mobileNo;
@property (nonatomic, strong) NSString *merchantNo;
@property (nonatomic, strong) NSString *idCardNo;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *payPassword;
@property (nonatomic, strong) NSString *photoUrl;
@property (nonatomic, strong) NSString *registerSrc;
@property (nonatomic, assign) long experience;
@property (nonatomic, strong) NSString *wxOpenId;
@property (nonatomic, strong) NSString *wxUnionId;
@property (nonatomic,strong) NSNumber *balance;//余额
@property (nonatomic,strong) NSNumber *integral;//积分
@property (nonatomic,strong) NSNumber *brokerage;//佣金
@end
