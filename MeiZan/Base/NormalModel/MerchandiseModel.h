//
//  MerchandiseModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/9.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchandiseModel : NSObject
@property (nonatomic, strong) NSNumber* CATEGORY_ID;
@property (nonatomic, strong) NSNumber* POST_PRICE;
@property (nonatomic, strong) NSNumber* PRICE;
@property (nonatomic, strong) NSNumber* DISCOUNT_PRICE;
@property (nonatomic, strong) NSNumber* COUNTY_AGENT_PRICE;
@property (nonatomic, strong) NSNumber* BUY_COUNT;
@property (nonatomic, strong) NSNumber* MAIN_AGENT_PRICE;
@property (nonatomic, strong) NSNumber* ID;
@property (nonatomic, strong) NSNumber* POINT;
@property (nonatomic, strong) NSString *UNIT;
@property (nonatomic, strong) NSString *GOODS_TITLE;
@property (nonatomic, strong) NSString *STYLE;
@property (nonatomic, strong) NSString *LAST_MODIFY_TIME;
@property (nonatomic, strong) NSString *SHOW_IMAGE_URL;
@property (nonatomic, strong) NSString *SHELF_TIME;
@property (nonatomic, strong) NSString *STATUS;
@property (nonatomic, strong) NSString *GOODS_NAME;
@property (nonatomic, strong) NSString *LOWE_TIME;
@property (nonatomic, strong) NSString *CONTENT;
@property (nonatomic, strong) NSString *CREATE_TIME;
@end
/*
"REAL_PRICE": 1,商品真实价格<number>
"POST_PRICE": 0,邮费<number>
"UNIT": "瓶",计数单位<string>
"PRICE": 18,商品出售价格<number>
"GOODS_TITLE": "瘦肉+香菇",商品标题<string>
"DISCOUNT_PRICE": 2.5,商品优惠价格<number>
"STYLE": "goods_tj",商品类型样式(goods_xp-新品;goods_rq-人气;goods_tj-推荐;goods_xs-限时;goods_yh-优惠)<string>
"LAST_MODIFY_TIME": "2017-12-27 16:00:28",最后修改时间<string>
"SHOW_IMAGE_URL": "http://localhost:8080/meizan-manager-web/goods/eb16fd66-0d6c-49a0-a3f8-89dceb841d2c.jpg",展示图片地址<string>
"SHELF_TIME": "2017-12-27 16:00:14",上架时间<string>
"COUNTY_AGENT_PRICE": 10,县代理价格<number>
"STATUS": "1",状态(是否上架:0-未上架;1-已上架;2-逻辑删除)<string>
"BUY_COUNT": 300,已购数量<number>
"GOODS_NAME": "蓝瘦香菇包",商品名称<string>
"MAIN_AGENT_PRICE": 13,总代理价格<number>
"LOWE_TIME": "2018-01-01 16:00:16",下架时间<string>
"ID": 2,商品id<number>
"CONTENT": "蓝瘦就吃蓝瘦香菇包",商品详情<string>
"CREATE_TIME": "2017-12-27 13:00:22",创建时间<string>
"POINT": 1商品出售积分<number>
*/
