//
//  ChargeRecordView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/31.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ChargeRecordView.h"
#import "ChargeRecordTableViewCell.h"
@interface ChargeRecordView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *mainTableView;
@end
@implementation ChargeRecordView
- (void)createSubview{
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[ChargeRecordTableViewCell class] forCellReuseIdentifier:@"ChargeRecordTableViewCell"];
    [self addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.bottom.mas_equalTo(self);
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
    ChargeRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChargeRecordTableViewCell"];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = [NSMutableArray arrayWithArray:dataArray];
    [self.mainTableView reloadData];
}

@end
