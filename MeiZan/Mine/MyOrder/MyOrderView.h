//
//  MyOrderView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"

@interface MyOrderView : BaseView
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) NSArray *dataArray;
@end
