//
//  MessageDetailTableViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/21.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "UserMessageModel.h"
@interface MessageDetailTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UserMessageModel *model;
@end
