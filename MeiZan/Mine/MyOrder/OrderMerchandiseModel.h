//
//  OrderMerchandiseModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/17.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderMerchandiseModel : NSObject
@property (nonatomic, strong) NSNumber *orderNo;
@property (nonatomic, strong) NSNumber *orderId;
@property (nonatomic, strong) NSNumber *specsId;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *number;
@property (nonatomic, strong) NSNumber *countPrice;
@property (nonatomic, strong) NSString *skuId;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *goodsTitle;
@property (nonatomic, strong) NSString *showImageUrl;
@property (nonatomic, strong) NSString *specsInfo;
@property (nonatomic, strong) NSString *createTime;
@end
/*"id": 13,订单商品表id<number>
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
 "createTime": "2018-01-02 11:14:18"<string>*/
