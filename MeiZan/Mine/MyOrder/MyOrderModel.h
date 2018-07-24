//
//  MyOrderModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/17.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OrderMerchandiseModel.h"
@interface MyOrderModel : NSObject
@property (nonatomic, strong) NSNumber *orderId;
@property (nonatomic, strong) NSNumber *DISCOUNT_PRICE;
@property (nonatomic, strong) NSNumber *USER_ID;
@property (nonatomic, strong) NSNumber *COUNTY_AGENT_PRICE;
@property (nonatomic, strong) NSNumber *MAIN_AGENT_PRICE;
@property (nonatomic, strong) NSNumber *DELIVER_MONEY;
@property (nonatomic, strong) NSNumber *COUNT_PRICE;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *PRICE;
@property (nonatomic, strong) NSNumber *goodsSize;
@property (nonatomic, strong) NSNumber *POINT;
@property (nonatomic, strong) NSString *ORDER_NO;
@property (nonatomic, strong) NSString *DELIVERY_TIME;
@property (nonatomic, strong) NSString *DISTRICT;
@property (nonatomic, strong) NSString *INVOICE_TYPE;
@property (nonatomic, strong) NSString *CREATE_TIME;
@property (nonatomic, strong) NSString *ORDER_STATUS;
@property (nonatomic, strong) NSString *PAYMENT_WAY;
@property (nonatomic, strong) NSString *ORDER_SRC;
@property (nonatomic, strong) NSString *CONSIGNEE;
@property (nonatomic, strong) NSString *MOBILE_NO;
@property (nonatomic, strong) NSString *CITY;
@property (nonatomic, strong) NSString *ORDER_REMARKS;
@property (nonatomic, strong) NSString *ADDRESS;
@property (nonatomic, strong) NSString *PROVINCE;
@property (nonatomic, strong) NSArray *goodsList;
@end
/*"orderId": 24,订单id<number>
 "DISCOUNT_PRICE": 0,优惠价格<number>
 -"goodsList": [订单商品列表<array>
 -{
 "id": 13,订单商品表id<number>
 "orderId": 24,订单id<number>
 "skuId": "2",规格商品id<string>
 "goodsName": "鲜肉包",商品名称<string>
 "goodsTitle": "瘦肉咸菜",商品标题<string>
 "showImageUrl": "http://localhost:8080/meizan-manager-web/goods/e8aa1a4d-a918-4c6a-9246-f57f10641d10.jpg",显示图片<string>
 "specsId": 2,规格商品参数id<number>
 "specsInfo": "鲜肉馅",规格参数名称<string>
 "price": 1,商品出售单价<number>
 "number": 1,购买数量<number>
 "countPrice": 1,出售总价<number>
 "createTime": "2018-01-02 11:14:18"<string>
 }
 ],
 "USER_ID": 10000008,用户id<number>
 "ORDER_NO": "1514862857527",订单号<string>
 "DELIVERY_TIME": "2018-01-05 00:00:00",运费<string>
 "COUNTY_AGENT_PRICE": 0.95,县代理总价格<number>
 "DISTRICT": "宝安区",区<string>
 "INVOICE_TYPE": "0",发票类型0不需要1个人2公司<string>
 "MAIN_AGENT_PRICE": 0.9,总代理总价格<number>
 "DELIVER_MONEY": 10,运费<number>
 "COUNT_PRICE": 1,总价格<number>
 "ID": 24,订单id<number>
 "CREATE_TIME": "2018-01-02 11:14:18",创建时间<string>
 "ORDER_STATUS": "0",订单状态(0-待支付1-已支付2-已发货3-已确认4-已评价5-已取消6-待审核7-审核失败)<string>
 "PAYMENT_WAY": "1",支付方式(1-微信2-支付宝3-余额支付4-线下打款)<string>
 "PRICE": 11,实际支付价格<number>
 "ORDER_SRC": "andioid",订单来源(ios;andioid)<string>
 "goodsSize": 1,订单商品个数<number>
 "CONSIGNEE": "龙俊奇",收货人姓名<string>
 "MOBILE_NO": "13423732017",手机号码<string>
 "CITY": "深圳",市<string>
 "ORDER_REMARKS": "呵呵",订单备注<string>
 "ADDRESS": "西乡街道宝金华大厦",收货地址<string>
 "PROVINCE": "广东",省<string>
 "POINT": 1购买积分<number>
 }*/
