//
//  ManageInvoiceView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ManageInvoiceView.h"
#import "ManageInvoiceTableViewCell.h"
#import "AddInvoiceViewController.h"
#import "ManageInvoiceViewController.h"
@interface ManageInvoiceView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end
@implementation ManageInvoiceView
- (void)createSubview{
    UIButton *addInvoice = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:0 fontSize:16 title:@"+ 添加发票抬头"];
    [addInvoice addTarget:self action:@selector(moveToAddInvoicePage:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addInvoice];
    [addInvoice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[ManageInvoiceTableViewCell class] forCellReuseIdentifier:@"ManageInvoiceTableViewCell"];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(addInvoice.mas_top);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.invoiceArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ManageInvoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManageInvoiceTableViewCell"];
    cell.model = self.invoiceArray[indexPath.row];
    if (indexPath.row == self.selectIndex) {
        cell.selectImg.image = [UIImage imageNamed:@"nick_select"];
    }else{
        cell.selectImg.image = [UIImage imageNamed:@"nick_unselect"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        InvoiceModel *model = self.invoiceArray[indexPath.row];
        [((ManageInvoiceViewController *)self.myViewController) deleteInvoice:[NSString stringWithFormat:@"%ld", model.invoiceId.integerValue]];
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

- (void)setInvoiceArray:(NSMutableArray *)invoiceArray{
    _invoiceArray = invoiceArray;
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectInvoice(self.invoiceArray[indexPath.row]);
    [self.myViewController.navigationController popViewControllerAnimated:YES];
}

- (void)moveToAddInvoicePage:(UIButton *)sender{
    AddInvoiceViewController *vc = [[AddInvoiceViewController alloc] initWithMoney:self.money phoneNum:self.phoneNumber];
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
