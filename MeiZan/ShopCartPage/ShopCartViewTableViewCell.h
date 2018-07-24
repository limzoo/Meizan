//
//  ShopCartViewTableViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/16.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "ShopCartModel.h"
#import "SelectNumView.h"
@interface ShopCartViewTableViewCell : BaseTableViewCell
@property (nonatomic, strong) ShopCartModel *model;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, strong) SelectNumView *selectNumView;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIButton *selectTypeButton;
@end
