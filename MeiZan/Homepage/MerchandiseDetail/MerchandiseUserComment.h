//
//  MerchandiseUserComment.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/9.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchandiseUserComment : NSObject
@property (nonatomic, strong) NSString *PHOTO_URL;
@property (nonatomic, strong) NSString *APPRAISES_ANNEX;
@property (nonatomic, strong) NSString *NICK_NAME;
@property (nonatomic, strong) NSString *SPECS_INFO;
@property (nonatomic, strong) NSString *IS_SHOW;
@property (nonatomic, strong) NSString *CONTENT;
@property (nonatomic, strong) NSString *CREATE_TIME;
@property (nonatomic, strong) NSString *TYPE;
@property (nonatomic, assign) long USER_ID;
@property (nonatomic, assign) long GOODS_SKU_ID;
@property (nonatomic, assign) long GOODS_SCORE;
@property (nonatomic, assign) long TIME_SCORE;
@property (nonatomic, assign) long ORDER_ID;
@property (nonatomic, assign) long ID;
@property (nonatomic, assign) long SERVICE_SCORE;

@end
/*"PHOTO_URL": "gif",用户头像<string>
 "APPRAISES_ANNEX": "",评价图片路径，以,号分隔<string>
 "USER_ID": 10000001,用户id<number>
 "GOODS_SKU_ID": 2,规格商品id<number>
 "NICK_NAME": "大汗",用户昵称<string>
 "GOODS_SCORE": 4,商品评分(1-5)<number>
 "SPECS_INFO": "鲜肉馅",购买的商品规格名称<string>
 "TIME_SCORE": 5,<number>
 "ORDER_ID": 1,订单id<number>
 "IS_SHOW": "0",昵称：1:显示 0:隐藏<string>
 "ID": 2,评论id<number>
 "CONTENT": "好评",评论内容<string>
 "CREATE_TIME": "2018-01-02 17:00:10",<string>
 "TYPE": "1",1:好评 2:中评 3:差评<string>
 "SERVICE_SCORE": 5<number>
*/
