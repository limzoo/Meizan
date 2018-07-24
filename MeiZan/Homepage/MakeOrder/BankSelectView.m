//
//  BankSelectView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/17.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BankSelectView.h"
#import "BankSelectViewTableViewCell.h"
#import "BankModel.h"
@interface BankSelectView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *ensureButton;
@property (nonatomic, assign) NSInteger index;
@end
@implementation BankSelectView
- (void)configInitial{
    self.index = -1;
}

- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *buttonView = [[UIView alloc] init];
    buttonView.backgroundColor = [UIColor whiteColor];
    [self addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(42);
    }];
    buttonView.layer.masksToBounds = NO;
    buttonView.layer.shadowColor = TEXTCOLOR.CGColor;
    buttonView.layer.shadowOffset = CGSizeMake(0, 2);
    buttonView.layer.shadowRadius = 4;
    buttonView.layer.shadowOpacity = 0.2;
    
    self.cancelButton = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0x666666) backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@"取消"];
    [self.cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:self.cancelButton];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self);
        make.bottom.top.mas_equalTo(buttonView);
        make.width.mas_equalTo(CUSTOM_WIDTH(90));
    }];
    
    self.ensureButton = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@"完成"];
     [self.ensureButton addTarget:self action:@selector(ensure) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:self.ensureButton];
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self);
         make.bottom.top.mas_equalTo(buttonView);
        make.width.mas_equalTo(CUSTOM_WIDTH(90));
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[BankSelectViewTableViewCell class] forCellReuseIdentifier:@"BankSelectViewTableViewCell"];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
        make.top.mas_equalTo(buttonView.mas_bottom).offset(2);
    }];
}

- (void)cancel{
    self.cancelButtonAction();
}

- (void)ensure{
    if (self.index == -1) {
        [Tool showMessage:@"请选择支付方式" duration:3];
        return;
    }
    self.ensureButtonAction(self.index);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bankArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BankSelectViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankSelectViewTableViewCell"];
    cell.model = self.bankArray[indexPath.row];
    if (self.index == indexPath.row) {
        cell.selectIMGV.image = [UIImage imageNamed:@"nick_select"];
    }else{
        cell.selectIMGV.image = [UIImage imageNamed:@"nick_unselect"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.index = indexPath.row;
    [self.tableView reloadData];
}

- (void)setBankArray:(NSArray *)bankArray{
    _bankArray = bankArray;
    [self.tableView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
