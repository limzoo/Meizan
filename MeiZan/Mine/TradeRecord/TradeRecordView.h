//
//  TradeRecordView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "TradeRecordModel.h"
@interface TradeRecordView : BaseView
@property (nonatomic, strong) NSMutableArray *dataModelArray;
@property (nonatomic, strong) UITableView *mainTableView;
@end
