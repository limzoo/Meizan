//
//  MerchantInfo.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchantInfo : NSObject<NSCoding>
@property (nonatomic, assign) long merchantId;
@property (nonatomic, strong) NSString *merchantNo;
@property (nonatomic, strong) NSString *merchantName;
@property (nonatomic, strong) NSString *merchantStatus;
@property (nonatomic, strong) NSString *authenticationStatus;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *lastModifyTime;
@property (nonatomic, strong) NSString *merchantAddress;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *desc;
@end
