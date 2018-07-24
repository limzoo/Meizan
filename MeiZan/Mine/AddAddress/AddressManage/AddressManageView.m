//
//  AddressManageView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "AddressManageView.h"
#import "AddressManageTableViewCell.h"
#import "AddressManageViewController.h"
#import "AddAddressViewController.h"
@interface AddressManageView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@end
@implementation AddressManageView
- (void)createSubview{
    UIImageView *titleLineIMGV = [[UIImageView alloc] init];
    titleLineIMGV.image = [UIImage imageNamed:@"addressLine"];
    [self addSubview:titleLineIMGV];
    [titleLineIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(self);
        make.height.mas_equalTo(4);
    }];
    
    UIButton *addButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:0 fontSize:16 title:@"+ 新建地址"];
    [addButton addTarget:self action:@selector(addNewAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableView registerClass:[AddressManageTableViewCell class] forCellReuseIdentifier:@"AddressManageTableViewCell"];
    [self addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(titleLineIMGV.mas_bottom);
        make.bottom.mas_equalTo(addButton.mas_top);
    }];
    self.mainTableView.tableFooterView = [[UIView alloc] init];
}

- (void)addNewAddress:(UIButton *)sender{
    AddAddressViewController *vc = [[AddAddressViewController alloc] init];
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressManageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressManageTableViewCell"];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.editButton.tag = indexPath.row;
    [cell.editButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)editAction:(UIButton *)sender{
    UserAddressModel *model = self.dataArray[sender.tag];
    AddAddressViewController *vc = [[AddAddressViewController alloc] init];
    vc.model = model;
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (((AddressManageViewController *)self.myViewController).shouldSelectBack) {
        self.backAddressModel(self.dataArray[indexPath.row]);
        [self.myViewController.navigationController popViewControllerAnimated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UserAddressModel *model = self.dataArray[indexPath.row];
        [((AddressManageViewController *)self.myViewController) deleteAddress:model];
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

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.mainTableView reloadData];
}
@end
