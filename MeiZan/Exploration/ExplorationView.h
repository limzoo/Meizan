//
//  ExplorationView.h
//  JingXuan
//
//  Created by sfs on 2017/12/19.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "UserMessageModel.h"
@interface ExplorationView : BaseView
@property (nonatomic, strong) NSArray *modelArray;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UITableView *mainTableView;
@end
