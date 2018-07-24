//
//  MakeOrderViewController.h
//  JingXuan
//
//  Created by sfs on 2017/12/14.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseViewController.h"
#import "MerchandiseSelectResultModel.h"
#import "PreOrderModel.h"
#import "InvoiceModel.h"
//#import "<#header#>"
@interface MakeOrderViewController : BaseViewController
@property (nonatomic, strong) NSMutableArray<MerchandiseSelectResultModel *> *merchandiseArray;
@property (nonatomic, strong) NSMutableArray *cartArrray;

- (instancetype)initWithCartId:(NSString *)cartId;
- (instancetype)initWithSkuId:(NSString *)skuId number:(NSString *)number;
- (void)preMakeOrder;
- (void)makeOrderWithCartId:(NSString *)cartId addressId:(NSString *)addressId invoiceId:(NSString *)invoiceId paymentWay:(NSInteger)paymentWay collectId:(NSString *)collectId deliveryTime:(NSString *)deliveryTime;
- (void)getBankCardList;
- (void)verifyPayPassword:(NSString *)password;
@end
