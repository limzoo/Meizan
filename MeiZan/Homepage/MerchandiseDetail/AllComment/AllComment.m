//
//  AllComment.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "AllComment.h"
#import "UserReplyTableViewCell.h"
#import "AllCommentViewController.h"
@interface AllComment()<UITableViewDelegate, UITableViewDataSource>

@end
@implementation AllComment
- (void)createSubview{
     self.backgroundColor = [UIColor whiteColor];
    
    UIView *selectTypeView = [[UIView alloc] init];
    [self addSubview:selectTypeView];
    [selectTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(65);
    }];
    
//    self.rateLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@""];
//    [selectTypeView addSubview:self.rateLabel];
//    [self.rateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(selectTypeView);
//        make.top.mas_equalTo(self).offset(20);
//    }];
    
    self.allButton = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:2 fontSize:14 title:@"全部"];
    self.allButton.layer.borderWidth = 0.5;
     self.allButton.tag = 100;
    [self.allButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    self.allButton.layer.borderColor = STYLECOLOR.CGColor;
    [selectTypeView addSubview:self.allButton];
    [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(32);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self).offset(20);
    }];
    
    self.haveButton = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:2 fontSize:14 title:@"有图"];
    self.haveButton.tag = 101;
     [self.haveButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    self.haveButton.layer.borderWidth = 0.5;
    self.haveButton.layer.borderColor = TEXTCOLOR.CGColor;
    [selectTypeView addSubview:self.haveButton];
    [self.haveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(32);
        make.leading.mas_equalTo(self.allButton.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self).offset(20);
    }];
    
    self.noneButton = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:2 fontSize:14 title:@"无图"];
     self.noneButton.tag = 102;
      [self.noneButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    self.noneButton.layer.borderWidth = 0.5;
    self.noneButton.layer.borderColor = TEXTCOLOR.CGColor;
    [selectTypeView addSubview:self.noneButton];
    [self.noneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(32);
        make.leading.mas_equalTo(self.haveButton.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self).offset(20);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [selectTypeView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(selectTypeView);
        make.bottom.mas_equalTo(selectTypeView.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[UserReplyTableViewCell class] forCellReuseIdentifier:@"UserReplyTableViewCell"];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self);
        make.top.mas_equalTo(selectTypeView.mas_bottom);
    }];
}
- (void)selectAction:(UIButton *)sender{
    for (int i = 100; i < 103; i++) {
        UIButton *button = [self viewWithTag:i];
        [button setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
        button.layer.borderColor = TEXTCOLOR.CGColor;
    }
    [sender setTitleColor:STYLECOLOR forState:UIControlStateNormal];
    sender.layer.borderColor = STYLECOLOR.CGColor;
    [((AllCommentViewController *)self.myViewController) loadPageDataWithType:[NSString stringWithFormat:@"%ld",sender.tag - 100] page:1];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserReplyTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"UserReplyTableViewCell"];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MerchandiseUserComment *model = self.dataArray[indexPath.row];
    if (model.APPRAISES_ANNEX.length > 0) {
        return 249;
    }else{
        return 125;
    }
    return 0;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
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
