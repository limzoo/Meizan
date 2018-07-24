//
//  CommissionRecordView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "CommissionRecordView.h"
#import "CommissionTableViewCell.h"
#import "TradeRecordModel.h"
@interface CommissionRecordView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@end
@implementation CommissionRecordView
- (void)createSubview{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self addSubview:self.mainTableView];
    [self.mainTableView registerClass:[CommissionTableViewCell class] forCellReuseIdentifier:@"CommissionTableViewCell"];
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.mas_equalTo(self);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommissionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommissionTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    if (self.dataArray.count == 0) {
        [Tool showNoDataPicOnView:self.mainTableView withImage:[UIImage imageNamed:@"订单空"] title:@"暂无记录" size:CGSizeMake(138, 140) topDistance:150];
    }else{
        [Tool hideNoDataPicOnView:self.mainTableView];
    }
    [self.mainTableView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
