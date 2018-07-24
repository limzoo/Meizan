//
//  BankSelectViewTableViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/17.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BankModel.h"
@interface BankSelectViewTableViewCell : BaseTableViewCell
@property (nonatomic, strong) BankModel *model;
@property (nonatomic, strong) UIImageView *selectIMGV;
@end
