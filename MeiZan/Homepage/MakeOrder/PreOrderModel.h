//
//  PreOrderModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/17.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserAddressModel.h"
#import "PreOrderMerchandise.h"
@interface PreOrderModel : NSObject
@property (nonatomic, strong) NSNumber* allPayPrice;
@property (nonatomic, strong) UserAddressModel *addressInfo;
@property (nonatomic, strong) NSNumber* allPrice;
@property (nonatomic, strong) NSNumber* postPrice;
@property (nonatomic, strong) NSNumber* invoiceId;
@property (nonatomic, strong) NSNumber* point;
@property (nonatomic, strong) NSNumber* cartId;
@property (nonatomic, strong) NSString *invoiceName;
@property (nonatomic, strong) NSArray *goodsList;
@property (nonatomic, strong) NSString *return_msg;
@property (nonatomic, strong) NSString *return_code;

@end
/*"allPayPrice": 15,应付总金额<number>
 -"addressInfo": {地址信息<object>
 "id": 3,地址id<number>
 "userId": 10000001,用户id<number>
 "province": "广东",省<string>
 "city": "深圳",市<string>
 "district": "宝安区",区<string>
 "address": "西乡街道宝金华大厦",收货地址<string>
 "consignee": "龙俊奇",收货人姓名<string>
 "mobileNo": "13423732017",手机号<string>
 "isDefault": "1",是否为默认地址<string>
 "createTime": "2017-12-26 18:33:04"创建时间<string>
 },
 "allPrice": 10,商品合计总金额<number>
 "invoiceName": "融和金通",发票抬头<string>
 "postPrice": 5,总邮费<number>
 "cartId": "12",购物车id<string>
 -"goodsList": [购买商品详情<array>
 +{ … }
 ],
 "return_msg": "查询成功",<string>
 "invoiceId": 2,发票id<number>
 "return_code": "0000",0000,0001<string>
 "point": 0总积分<number>
 }*/
