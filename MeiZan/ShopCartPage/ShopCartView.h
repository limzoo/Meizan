//
//  ShopCartView.h
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "ShopCartViewTableViewCell.h"
#import "ShopCartViewController.h"
#import "MakeOrderViewController.h"
#import "MerchandiseSelectTypeViewController.h"
@interface ShopCartView : BaseView
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UILabel *ammountLabel;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableDictionary *selectMerchandiseDict;
@property (nonatomic, assign) BOOL isEdit;//是否全选
@property (nonatomic, assign) NSInteger editRow;//是否单行选择

@property (nonatomic, strong) UIView *selectTypeView;
@property (nonatomic, strong) MerchandiseSelectTypeViewController *selectVC;
@property (nonatomic, strong) UIView *masksView;
@property (nonatomic, strong) UIButton *payOrderButton;
@property (nonatomic, assign) BOOL isAllSelect;

@end
