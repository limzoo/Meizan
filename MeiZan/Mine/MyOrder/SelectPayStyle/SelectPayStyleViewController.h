//
//  SelectPayStyleViewController.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseViewController.h"
#import "MyOrderModel.h"
@interface SelectPayStyleViewController : BaseViewController
- (instancetype)initWithOrderModel:(MyOrderModel *)orderModel;
- (void)payWithPayType:(NSInteger)payType;
- (void)verifyPayPassword:(NSString *)password;
- (void)getBankCardList;

@end
