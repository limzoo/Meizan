//
//  MerchandiseSelectTypeViewController.h
//  JingXuan
//
//  Created by sfs on 2017/12/13.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseViewController.h"
#import "MerchandiseDetailModel.h"
@interface MerchandiseSelectTypeViewController : BaseViewController
@property (nonatomic, strong) MerchandiseDetailModel *model;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) UIViewController *baseVC;
@property (nonatomic, strong) NSString *shopCardId;
- (instancetype)initWithType:(NSInteger)type;
- (void)addToShopCartWithNumber:(NSInteger)num;
- (void)getMerchandiseMessageWithSpecsId:(NSString *)specsId goodsId:(NSNumber *)goodsId;
- (void)changeMerchandise:(NSString *)modelId skuId:(NSString *)skuId selectNum:(NSInteger)num;
@end
