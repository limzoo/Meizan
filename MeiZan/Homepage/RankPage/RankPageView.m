//
//  RankPageView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/15.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "RankPageView.h"
#import "LYSlideSelectBar.h"
#import "RankPageViewTableViewCell.h"
#import "RankDetailViewController.h"
@interface RankPageView()<LYSlideSelectBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LYSlideSelectBar *slideBar;

@property (nonatomic, strong) NSArray *currentDataArray;

@property (nonatomic, strong) NSMutableArray *array_1;
@property (nonatomic, strong) NSMutableArray *array_2;
@end
@implementation RankPageView
- (void)createSubview{
    self.slideBar = [[LYSlideSelectBar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44) itemNum:2 slideViewBounds:CGSizeMake(CUSTOM_WIDTH(50), 2)];
    self.slideBar.titles = @[@"进货排名",@"增长排名"];
    self.slideBar.titlesFont = @[[UIFont fontWithName:@"PingFangSC-Regular" size:16],  [UIFont fontWithName:@"PingFangSC-Regular" size:16]];
    [self.slideBar setItemTinColor:STYLECOLOR defaultColor:TEXTCOLOR];
    [self.slideBar setSlideViewTinColor:STYLECOLOR];
    self.slideBar.delegate = self;
    [self addSubview:self.slideBar];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.slideBar.mas_bottom);
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[RankPageViewTableViewCell class] forCellReuseIdentifier:@"RankPageViewTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.slideBar.mas_bottom).offset(1);
        make.leading.trailing.bottom.mas_equalTo(self);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.currentDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankPageViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankPageViewTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.currentDataArray[indexPath.row];
    cell.iconIMGV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row + 1]];
    return cell;
}

- (void)slideSelectBar:(LYSlideSelectBar *)slideSelectBar didSelectAnotherItemAtIndex:(NSUInteger)index{
    switch (index) {
        case 0:{
            self.currentDataArray = self.array_1;
            [self.tableView reloadData];
            break;
        }
        case 1:{
            self.currentDataArray = self.array_2;
            [self.tableView reloadData];
            break;
        }
        default:
            break;
    }
}
- (void)setTitlesArray:(NSArray *)titlesArray{
    [self.array_1 removeAllObjects];
    [self.array_2 removeAllObjects];
    for (UserMessageModel *model in titlesArray) {
        if ([model.MESSAGE_TITLE containsString:@"增长"]) {
            [self.array_2 addObject:model];
        }else{
            [self.array_1 addObject:model];
        }
    }
    switch ( _slideBar.currentSelectedIndex) {
        case 0:
            self.currentDataArray = self.array_1;
            break;
        case 1:
            self.currentDataArray = self.array_2;
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserMessageModel *model = self.currentDataArray[indexPath.row];
    RankDetailViewController *vc = [[RankDetailViewController alloc] initWithNewsTitles:model.MESSAGE_TITLE];
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)currentDataArray{
    if (!_currentDataArray) {
        _currentDataArray = [NSArray array];
    }
    return _currentDataArray;
}

- (NSMutableArray *)array_1{
    if (!_array_1) {
        _array_1 = [NSMutableArray array];
    }
    return _array_1;
}
- (NSMutableArray *)array_2{
    if (!_array_2) {
        _array_2 = [NSMutableArray array];
    }
    return _array_2;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
