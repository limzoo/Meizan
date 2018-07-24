//
//  MerchandiseSelectResultModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/16.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchandiseSelectResultModel : NSObject
@property (nonatomic, assign) long selectMerchandiseId;
@property (nonatomic, assign) long goodsId;
@property (nonatomic, assign) long price;
@property (nonatomic, assign) long mainAgentPrice;
@property (nonatomic, assign) long countyAgentPrice;
@property (nonatomic, assign) long point;
@property (nonatomic, assign) long realPrice;
@property (nonatomic, assign) long discountPrice;
@property (nonatomic, assign) long stockCount;
@property (nonatomic, assign) long stockValveCount;
@property (nonatomic, strong) NSString *specsId;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *showImageUrl;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *shelfTime;
@property (nonatomic, strong) NSString *loweTime;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *lastModifyTime;
@end
/*"id": 2,规格商品id<number>
 "goodsId": 1,商品id<number>
 "specsId": "2",规格参数id<string>
 "price": 1,商品出售价格<number>
 "mainAgentPrice": 1,总代理价格<number>
 "countyAgentPrice": 1,县代理价格<number>
 "point": 1,商品出售积分<number>
 "realPrice": 1,商品真实价格<number>
 "discountPrice": 1,商品优惠价格<number>
 "status": "1",状态(是否上架:0-未上架;1-已上架)<string>
 "stockCount": 5,库存数量<number>
 "stockValveCount": 6,库存阀值<number>
 "showImageUrl": "http://localhost:8080/meizan-manager-web/goods/e8aa1a4d-a918-4c6a-9246-f57f10641d10.jpg",展示图片地址<string>
 "content": "1",商品详情<string>
 "shelfTime": "2017-12-26 18:21:39",定时上架时间<string>
 "loweTime": "2017-12-27 09:27:44",定时下架时间<string>
 "createTime": "2017-12-26 15:05:30",创建时间<string>
 "lastModifyTime": "2017-12-28 10:50:22"最后修改时间<string>
*/
