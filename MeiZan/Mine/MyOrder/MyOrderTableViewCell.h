//
//  MyOrderTableViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MyOrderModel.h"
@interface MyOrderTableViewCell : BaseTableViewCell
@property (nonatomic, strong) MyOrderModel *model;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIButton *middleButton;
@property (nonatomic, strong) UIButton *leftButton;
@end
