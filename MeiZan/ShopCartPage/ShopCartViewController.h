//
//  ShopCartViewController.h
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseViewController.h"
#import "ShopCartModel.h"
@interface ShopCartViewController : BaseViewController
- (void)deleteItemFromShopCartWithId:(NSString *)Id row:(NSInteger)row;
- (void)deleteSelectItemFromShopCartWithId:(NSString *)Id;
- (void)changeMerchandise:(ShopCartModel *)model selectNum:(NSInteger)num;
- (void)getPageDataWithCartId:(NSString *)cartId skuId:(NSString *)skuId goodsId:(NSString *)goodsId number:(NSString *)number shopCartId:(NSString *)shopCartId;
- (void)deleteAllItem;
- (void)loadPageData;
@end
