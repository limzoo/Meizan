//
//  MyOrderDetailView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/24.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "MyOrderModel.h"
@interface MyOrderDetailView : BaseView
@property (nonatomic, strong) MyOrderModel *orderModel;
@property (nonatomic, strong) NSDictionary *responseObject;
@end
