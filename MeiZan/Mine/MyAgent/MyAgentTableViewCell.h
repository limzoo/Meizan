//
//  MyAgentTableViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MyAgentModel.h"
@interface MyAgentTableViewCell : BaseTableViewCell
@property (nonatomic, strong) MyAgentModel *model;
//@property (nonatomic, assign) BOOL isHead;//是否显示头部点
@property (nonatomic, assign) BOOL shouldHaveLeftInset;//左边距
@property (nonatomic, strong) NSIndexPath *indexPath;
@end
