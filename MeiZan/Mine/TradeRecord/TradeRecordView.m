
//
//  TradeRecordView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "TradeRecordView.h"
#import "TradeRecordDetailTableViewCell.h"
@interface TradeRecordView()<UITableViewDelegate, UITableViewDataSource>

@end
@implementation TradeRecordView
- (void)createSubview{
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.mainTableView];
    self.mainTableView.tableFooterView = [[UIView alloc] init];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[TradeRecordDetailTableViewCell class] forCellReuseIdentifier:@"TradeRecordDetailTableViewCell"];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.bottom.mas_equalTo(self);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TradeRecordDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TradeRecordDetailTableViewCell"];
    cell.model = self.dataModelArray[indexPath.row];
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *view = [[UIView alloc] init];
//    view.backgroundColor = COLOR_RGB16(0xfafafa);
//    UILabel *label = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x999999) text:@"2017年12月"];
//    [view addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(view);
//        make.leading.mas_equalTo(view).offset(CUSTOM_WIDTH(14));
//    }];
//    return view;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 44;
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
