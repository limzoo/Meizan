//
//  ShopCartView.m
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "ShopCartView.h"
//#import "ShopCartMerchandiseCollectionViewCell.h"
#import "ShopCartViewTableViewCell.h"
#import "ShopCartViewController.h"
#import "MakeOrderViewController.h"
#import "MerchandiseSelectTypeViewController.h"
@interface ShopCartView ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *selectAllButton;
@end
@implementation ShopCartView
#pragma mark -<collectionView>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
}

- (void)setIsEdit:(BOOL)isEdit{
    _editRow = -1;
    _isEdit = isEdit;
    if (isEdit) {
        [_payOrderButton setTitle:@"删除所选" forState:UIControlStateNormal];
    }else{
        [_payOrderButton setTitle:@"去结账" forState:UIControlStateNormal];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopCartViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopCartViewTableViewCell"];
    cell.selectedButton.tag = indexPath.row + 100;
    cell.editButton.tag = indexPath.row;
    cell.selectTypeButton.tag = indexPath.row + 100;
    if ([self.selectMerchandiseDict objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] == nil) {
        [cell.selectedButton setImage:[UIImage imageNamed:@"nick_unselect"] forState:UIControlStateNormal];
    }else{
        [cell.selectedButton setImage:[UIImage imageNamed:@"nick_select"] forState:UIControlStateNormal];
    }
    [cell.editButton addTarget:self action:@selector(setCellSelected:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectTypeButton addTarget:self action:@selector(updateMerchantType:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectedButton addTarget:self action:@selector(selectMerchandise:) forControlEvents:UIControlEventTouchUpInside];
    if (self.isEdit || self.editRow == indexPath.row) {
        cell.isEdit = YES;
    }else{
        cell.isEdit = NO;
    }
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.selectNumView.changeSelectNum = ^(NSUInteger num) {
        [((ShopCartViewController *)self.myViewController) changeMerchandise:self.dataArray[indexPath.row] selectNum:num];
    };
    return cell;
}

- (void)setCellSelected:(UIButton *)button{
    if (self.editRow != button.tag) {
        self.editRow = button.tag;
    }else{
        self.editRow = -1;
    }
    [self.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:button.tag inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)updateMerchantType:(UIButton *)button{
    ShopCartModel *model = self.dataArray[button.tag - 100];
    [((ShopCartViewController *)self.myViewController) getPageDataWithCartId:[NSString stringWithFormat:@"%ld", model.ID.longValue] skuId:model.SKU_ID goodsId:[NSString stringWithFormat:@"%ld", model.GOODS_ID.longValue] number:[NSString stringWithFormat:@"%ld", model.NUMBER.longValue] shopCartId:[NSString stringWithFormat:@"%ld", model.ID.longValue]];
}

- (void)selectMerchandise:(UIButton *)button{
    NSString *key = [NSString stringWithFormat:@"%ld",button.tag - 100];
    if ([self.selectMerchandiseDict objectForKey:key] == nil) {
        [self.selectMerchandiseDict setObject:[NSIndexPath indexPathForRow:button.tag - 100 inSection:0] forKey:key];
    }else{
        [self.selectMerchandiseDict removeObjectForKey:key];
    }
    [self changeView];
    [self.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:button.tag - 100 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)changeView{
    if (self.selectMerchandiseDict.count > 0 ) {
        self.payOrderButton.backgroundColor = STYLECOLOR;
        float sum = 0;
        UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
        switch (config.userInfo.userType.intValue) {
            case 1:{
                for (NSIndexPath *indexPath in [self.selectMerchandiseDict allValues]) {
                    ShopCartModel *model = self.dataArray[indexPath.row];
                    sum = sum + model.PRICE.floatValue * model.NUMBER.integerValue;
                }
                break;
            }
            case 2:{
                for (NSIndexPath *indexPath in [self.selectMerchandiseDict allValues]) {
                    ShopCartModel *model = self.dataArray[indexPath.row];
                    sum = sum + model.PRICE.floatValue * model.NUMBER.integerValue;
                }
                break;
            }
            case 3:{
                for (NSIndexPath *indexPath in [self.selectMerchandiseDict allValues]) {
                    ShopCartModel *model = self.dataArray[indexPath.row];
                    sum = sum + model.MAIN_AGENT_PRICE.floatValue * model.NUMBER.integerValue;
                }
                break;
            }
            case 4:{
                for (NSIndexPath *indexPath in [self.selectMerchandiseDict allValues]) {
                    ShopCartModel *model = self.dataArray[indexPath.row];
                    sum = sum + model.COUNTY_AGENT_PRICE.floatValue * model.NUMBER.integerValue;
                }
                break;
            }
            default:
                break;
        }
        self.ammountLabel.text = [NSString stringWithFormat:@"¥ %.2f",sum];
    }else{
        self.payOrderButton.backgroundColor = COLOR_RGB16(0xd8d8d8);
        self.ammountLabel.text = [NSString stringWithFormat:@"¥ 0.0"];
    }
    
    if (self.selectMerchandiseDict.count == self.dataArray.count) {
        self.isAllSelect = YES;
        [self.selectAllButton setImage:[UIImage imageNamed:@"nick_select"] forState:UIControlStateNormal];
    }else if(self.selectMerchandiseDict.count < self.dataArray.count && self.isAllSelect == YES){
        self.isAllSelect = NO;
        [self.selectAllButton setImage:[UIImage imageNamed:@"nick_unselect"] forState:UIControlStateNormal];
    }
}

- (void)selectAll:(UIButton *)sender{
    self.isAllSelect = !self.isAllSelect;
    if (self.isAllSelect) {
        [sender setImage:[UIImage imageNamed:@"nick_select"] forState:UIControlStateNormal];
        for (int i = 0; i < self.dataArray.count; i ++) {
            [self.selectMerchandiseDict setObject:[NSIndexPath indexPathForRow:i inSection:0] forKey:[NSString stringWithFormat:@"%d",i]];
        }
    }else{
        [sender setImage:[UIImage imageNamed:@"nick_unselect"] forState:UIControlStateNormal];
        [self.selectMerchandiseDict removeAllObjects];
    }
    [self changeView];
    [self.mainTableView reloadData];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ShopCartModel *model = self.dataArray[indexPath.row];
        [((ShopCartViewController  *)self.myViewController) deleteItemFromShopCartWithId:[NSString stringWithFormat:@"%ld",model.ID.longValue] row:indexPath.row];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  UITableViewCellEditingStyleDelete;
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = [NSMutableArray arrayWithArray:dataArray];
    [self.mainTableView reloadData];
    if (self.dataArray.count == 0) {
        [Tool showNoDataPicOnView:self withImage:[UIImage imageNamed:@"购物车空"] title:@"去添加点什么吧" size:CGSizeMake(134, 134) topDistance:120];
    }else{
        [Tool hideNoDataPicOnView:self];
    }
}

- (NSMutableDictionary *)selectMerchandiseDict{
    if (!_selectMerchandiseDict) {
        _selectMerchandiseDict = [NSMutableDictionary dictionary];
    }
    return _selectMerchandiseDict;
}

- (void)createSubview{
    self.backgroundColor = INSETCOLOR_F5;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeMaskPage) name:@"removeSelectPage" object:nil];
    
    self.masksView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    self.masksView.hidden = YES;
    self.masksView.alpha = 0;
    self.masksView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:self.masksView];
    [self.masksView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo([UIApplication sharedApplication].keyWindow);
        make.bottom.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
    
    //    self.selectVC = [[MerchandiseSelectTypeViewController alloc] initWithType:2];
    ////    self.selectVC.dataArray = self.typeModelArray;
    //    self.selectTypeView = [[UIView alloc] init];
    //    self.selectTypeView.backgroundColor = [UIColor whiteColor];
    //    [self.masksView addSubview:self.selectTypeView];
    //    [self.selectTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.trailing.bottom.mas_equalTo(self.masksView);
    //        make.height.mas_equalTo(0);
    //    }];
    //
    //    [self.selectTypeView addSubview:self.selectVC.view];
    //    [self.selectVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.leading.top.bottom.trailing.mas_equalTo(self.selectTypeView);
    //    }];
    //
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableView.backgroundColor = INSETCOLOR_F5;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[ShopCartViewTableViewCell class] forCellReuseIdentifier:@"ShopCartViewTableViewCell"];
    [self addSubview:self.mainTableView];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [((ShopCartViewController *)self.myViewController) loadPageData];
        [self.mainTableView.mj_header endRefreshing];
    }];
    
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(49);
        make.bottom.mas_equalTo(self).offset(-1);
    }];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(-1);
    }];
    
    
    self.selectAllButton = [UIButton initCustomTypeButtonWithTextColor:TITLECOLOR backGroudColor:COLOR_RGB16(0xffffff) cornerRadius:0 fontSize:14 title:@"全选"];
    [self.selectAllButton setImage:[UIImage imageNamed:@"nick_unselect"] forState:UIControlStateNormal];
    self.selectAllButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [self.selectAllButton addTarget:self action:@selector(selectAll:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.selectAllButton];
    [self.selectAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.leading.mas_equalTo(self.bottomView).offset(14);
        make.width.mas_equalTo(62);
        make.height.mas_equalTo(18);
    }];
    
    self.payOrderButton = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0xffffff) backGroudColor:COLOR_RGB16(0xd8d8d8) cornerRadius:0 fontSize:16 title:@"去结账"];
    [self.payOrderButton addTarget:self action:@selector(moveToMakeOrderPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomView addSubview:self.payOrderButton];
    [self.payOrderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.trailing.mas_equalTo(self.bottomView);
        make.width.mas_equalTo(CUSTOM_WIDTH(140));
    }];
    
    self.ammountLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:STYLECOLOR text:nil];
    [self.bottomView addSubview:self.ammountLabel];
    [self.ammountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bottomView);
        make.trailing.mas_equalTo(self.payOrderButton.mas_leading).offset(-CUSTOM_WIDTH(14));
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self layoutIfNeeded];
}
- (void)keyboardWillShow:(NSNotification *)aNotification

{
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y;  // 得到键盘弹出后的键盘视图所在y坐标
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    int height = keyboardRect.size.height;
    if (self.masksView.hidden == YES) {
        // 添加移动动画，使视图跟随键盘移动
        //        [UIView animateWithDuration:duration.doubleValue animations:^{
        //            [UIView setAnimationBeginsFromCurrentState:YES];
        //            [UIView setAnimationCurve:[curve intValue]];
        //
        //        }];
        [UIView animateWithDuration:duration.doubleValue animations:^{
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:[curve intValue]];
            [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self).offset(-(height - self.myViewController.tabBarController.tabBar.bounds.size.height));
            }];
            [self layoutIfNeeded];
        }];
        return;
    }
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [self.selectTypeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.masksView).offset(-height);
        }];
        [self layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)aNotification{
    if (self.masksView.hidden == YES) {
        NSDictionary *userInfo = [aNotification userInfo];
        NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
        [UIView animateWithDuration:duration.doubleValue animations:^{
            [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self);
            }];
            [self layoutIfNeeded];
        }];
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.selectTypeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.masksView);
        }];
    });
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
- (void)moveToMakeOrderPage:(UIButton *)sender{
    if (self.isEdit) {
       
            NSMutableArray *tempArray = [NSMutableArray array];
            NSString *tempStr = [[NSString alloc] init];
            for (NSIndexPath *indexPath in [self.selectMerchandiseDict allValues]) {
                ShopCartModel *model = self.dataArray[indexPath.row];
                [tempArray addObject:model];
                if (tempStr.length == 0) {
                    tempStr = [NSString stringWithFormat:@"%ld", model.ID.longValue];
                }else{
                    tempStr = [tempStr stringByAppendingString:[NSString stringWithFormat:@",%ld", model.ID.longValue]];
                }
            }
        if (tempArray.count == 0) {
            [Tool showMessage:@"请选择商品" duration:3];
            return;
        }
        [((ShopCartViewController *)self.myViewController)  deleteSelectItemFromShopCartWithId:tempStr];
    }else{
        NSMutableArray *tempArray = [NSMutableArray array];
        NSString *tempStr = [[NSString alloc] init];
        for (NSIndexPath *indexPath in [self.selectMerchandiseDict allValues]) {
            ShopCartModel *model = self.dataArray[indexPath.row];
            [tempArray addObject:model];
            if (tempStr.length == 0) {
                tempStr = [NSString stringWithFormat:@"%ld", model.ID.integerValue];
            }else{
                tempStr = [tempStr stringByAppendingString:[NSString stringWithFormat:@",%ld", model.ID.longValue]];
            }
        }
        if (tempArray.count == 0) {
            [Tool showMessage:@"请选择商品" duration:3];
            return;
        }
        MakeOrderViewController *vc = [[MakeOrderViewController alloc] initWithCartId:tempStr];
        vc.hidesBottomBarWhenPushed = YES;
        vc.cartArrray = tempArray;
        [self.myViewController.navigationController pushViewController:vc animated:YES];
    }
}

- (void)configInitial{
    self.isAllSelect = NO;
    self.editRow = -1;
}

- (void)removeMaskPage{
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.4 animations:^{
            self.masksView.alpha = 0;
        } completion:^(BOOL finished) {
            self.masksView.hidden = YES;
            [((ShopCartViewController *)self.myViewController) loadPageData];
        }];
    });
}
@end
