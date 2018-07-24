//
//  ShopCartModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/16.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCartModel : NSObject
@property (nonatomic, strong) NSString *STATUS;
@property (nonatomic, strong) NSString *SKU_ID;
@property (nonatomic, strong) NSString *GOODS_NAME;
@property (nonatomic, strong) NSString *GOODS_TITLE;
@property (nonatomic, strong) NSString *specsInfo;
@property (nonatomic, strong) NSString *SPECS_ID;
@property (nonatomic, strong) NSString *SHOW_IMAGE_URL;
@property (nonatomic, strong) NSNumber* NUMBER;
@property (nonatomic, strong) NSNumber* PRICE;
@property (nonatomic, strong) NSNumber* STOCK_COUNT;
@property (nonatomic, strong) NSNumber* GOODS_ID;
@property (nonatomic, strong) NSNumber* ID;
@property (nonatomic, strong) NSNumber* COUNTY_AGENT_PRICE;
@property (nonatomic, strong) NSNumber* MAIN_AGENT_PRICE;
@property (nonatomic, strong) NSNumber* POINT;
@end
/*
 "STATUS": "1",状态(是否上架:0-未上架;1-已上架)<string>
 "NUMBER": 1,购买数量<number>
 "PRICE": 2,商品出售价格<number>
 "SKU_ID": "10001",商品规格id<string>
 "GOODS_NAME": "蓝瘦香菇包",商品名称<string>
 "GOODS_TITLE": "瘦肉+香菇",商品标题<string>
 "STOCK_COUNT": 999,库存数量<number>
 "GOODS_ID": 2,商品id<number>
 "specsInfo": "鲜肉馅,香菇馅",规格信息<string>
 "SPECS_ID": "2,9",商品规格参数id<string>
 "SHOW_IMAGE_URL": "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2703180632,4178058491&fm=27&gp=0.jpg",展示图片地址<string>
 "ID": 1购物车id<number>

 */
