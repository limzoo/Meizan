//
//  MyOrderViewController.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseViewController.h"
#import "MyOrderModel.h"
@interface MyOrderViewController : BaseViewController
@property (nonatomic, assign) NSInteger page;
- (void)loadPageDataWithIndex:(NSInteger)index page:(NSInteger)page;
- (instancetype)initWithIndex:(NSInteger)index;
- (void)updateOrder:(MyOrderModel *)order status:(NSInteger)status;
@end
