//
//  MerchandiseDetailModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/9.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MerchandiseDetailModel : NSObject
@property (nonatomic, strong) NSNumber *merchandiseId;
@property (nonatomic, strong) NSNumber *categoryId;
@property (nonatomic, strong) NSNumber * price;
@property (nonatomic, strong) NSNumber * mainAgentPrice;
@property (nonatomic, strong) NSNumber * point;
@property (nonatomic, strong) NSNumber * realPrice;
@property (nonatomic, strong) NSNumber * discountPrice;
@property (nonatomic, strong) NSNumber * postPrice;
@property (nonatomic, strong) NSNumber * countyAgentPrice;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *goodsTitle;
@property (nonatomic, strong) NSString *showImageUrl;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *style;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *loweTime;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *lastModifyTime;
@property (nonatomic, strong) NSArray *goodsImages;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSString *rate;
@property (nonatomic, strong) NSNumber *buyCount;
@property (nonatomic, strong) NSNumber *salesCount;
@property (nonatomic, strong) NSNumber *shopCartNum;
@end
/*"id": 1,商品id<number>
 "goodsName": "鲜肉包",商品名称<string>
 "goodsTitle": "瘦肉咸菜",商品标题<string>
 "categoryId": 9,类别ID<number>
 "price": 1,商品出售价格<number>
 "mainAgentPrice": 1,总代理价格<number>
 "countyAgentPrice": 1,县代理价格<number>
 "point": 1,商品出售积分<number>
 "realPrice": 1,商品真实价格<number>
 "discountPrice": 1,商品优惠价格<number>
 "postPrice": 5,邮费<number>
 "showImageUrl": "http://localhost:8080/meizan-manager-web/goods/eb16fd66-0d6c-49a0-a3f8-89dceb841d2c.jpg",展示图片地址<string>
 "status": "0",状态(是否上架:0-未上架;1-已上架;2-逻辑删除)<string>
 "style": "goods_yh",商品类型样式(goods_xp-新品;goods_rq-人气;goods_tj-推荐;goods_xs-限时;goods_yh-优惠)<string>
 "content": "12312",商品详情<string>
 "loweTime": "2017-12-27 09:27:44",<string>
 "createTime": "2017-12-26 15:05:30",<string>
 "lastModifyTime": "2017-12-27 09:27:44"<string>
*/

