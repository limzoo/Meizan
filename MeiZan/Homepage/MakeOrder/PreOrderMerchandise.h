//
//  PreOrderMerchandise.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/17.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PreOrderMerchandise : NSObject
@property (nonatomic, strong) NSNumber *REAL_PRICE;
@property (nonatomic, strong) NSNumber *NUMBER;
@property (nonatomic, strong) NSNumber *POST_PRICE;
@property (nonatomic, strong) NSNumber *PRICE;
@property (nonatomic, strong) NSNumber *goodsId;
@property (nonatomic, strong) NSNumber *USER_ID;
@property (nonatomic, strong) NSNumber *COUNTY_AGENT_PRICE;
@property (nonatomic, strong) NSNumber *MAIN_AGENT_PRICE;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *POINT;
@property (nonatomic, strong) NSNumber *skuId;
@property (nonatomic, strong) NSString *GOODS_TITLE;
@property (nonatomic, strong) NSString *LAST_MODIFY_TIME;
@property (nonatomic, strong) NSString *SHOW_IMAGE_URL;
@property (nonatomic, strong) NSString *SPECS_ID;
@property (nonatomic, strong) NSString *SKU_ID;
@property (nonatomic, strong) NSString *GOODS_NAME;
@property (nonatomic, strong) NSString *specsInfo;
@property (nonatomic, strong) NSString *CREATE_TIME;
@end
/*"REAL_PRICE": 1,真实价格<number>
 "NUMBER": 10,购买数量<number>
 "POST_PRICE": 5,单个商品邮费<number>
 "PRICE": 1,出售价格<number>
 "goodsId": 1,商品id<number>
 "GOODS_TITLE": "瘦肉咸菜",商品标题<string>
 "USER_ID": 10000001,<number>
 "LAST_MODIFY_TIME": "2018-01-12 12:04:07",<string>
 "SHOW_IMAGE_URL": "http://localhost:8080/meizan-manager-web/goods/e8aa1a4d-a918-4c6a-9246-f57f10641d10.jpg",商品显示图片<string>
 "SPECS_ID": "2",规格参数id<string>
 "COUNTY_AGENT_PRICE": 0.95,总代理单价<number>
 "SKU_ID": "2",规格商品id<string>
 "GOODS_NAME": "鲜肉包",商品名称<string>
 "MAIN_AGENT_PRICE": 0.9,县代理单价<number>
 "specsInfo": "鲜肉馅",规格参数名称<string>
 "ID": 12,商品id<number>
 "CREATE_TIME": "2018-01-08 11:31:25",<string>
 "POINT": 0,商品出售积分<number>
 "skuId": 2规格商品id<number>
*/
