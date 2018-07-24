//
//  RankPageViewTableViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/15.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "UserMessageModel.h"
@interface RankPageViewTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UserMessageModel *model;
@property (nonatomic, strong) UIImageView *iconIMGV;
@property (nonatomic, assign) NSInteger rank;
@end
