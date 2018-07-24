//
//  UserAddressModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/17.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserAddressModel : NSObject
@property (nonatomic, assign) long addressId;
@property (nonatomic, assign) long userId;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *consignee;
@property (nonatomic, strong) NSString *mobileNo;
@property (nonatomic, strong) NSString *isDefault;
@property (nonatomic, strong) NSString *createTime;
@end
/*"id": 1,地址id<number>
 "userId": 10000001,用户id<number>
 "province": "广东",省<string>
 "city": "深圳",市<string>
 "district": "宝安区",区<string>
 "address": "西乡",收货地址<string>
 "consignee": "龙俊奇",收货人姓名<string>
 "mobileNo": "13423732017",电话<string>
 "isDefault": "1",是否默认(0-否;1-是)<string>
 "createTime": "2017-12-26 18:20:48"创建时间<string>
 */
