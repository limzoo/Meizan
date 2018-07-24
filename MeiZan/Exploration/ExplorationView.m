//
//  ExplorationView.m
//  JingXuan
//
//  Created by sfs on 2017/12/19.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "ExplorationView.h"
#import "ExplorationViewDetailTableViewCell.h"
#import "LYSlideSelectBar.h"
#import "ExplorationViewController.h"
#import "MessageDetailViewController.h"
#import "RankDetailViewController.h"
@interface ExplorationView()<LYSlideSelectBarDelegate,UITableViewDelegate, UITableViewDataSource>
@end
@implementation ExplorationView
- (void)configInitial{
    self.currentIndex = 0;
    self.currentPage = 1;
}

- (void)createSubview{
    LYSlideSelectBar *selectBar = [[LYSlideSelectBar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 48) itemNum:2 slideViewBounds:CGSizeMake(64, 2)];
    selectBar.titles = @[@"公司消息",@"私信"];
    selectBar.titlesFont = @[[UIFont fontWithName:@"PingFangSC-Regular" size:14], [UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [selectBar setSlideViewTinColor:STYLECOLOR];
    [selectBar  setItemTinColor:STYLECOLOR defaultColor:COLOR_RGB16(0x999999)];
    selectBar.delegate = self;
    selectBar.layer.shadowOffset = CGSizeMake(0, 1);
    selectBar.layer.shadowColor = COLOR_RGB16(0x333333).CGColor;
    selectBar.layer.shadowOpacity = 0.1;
    selectBar.layer.shadowRadius = 0;
    [self addSubview:selectBar];
    __weak typeof(self) weakSelf = self;
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
        [((ExplorationViewController *)weakSelf.myViewController) loadPageDataWithType:self.currentIndex + 1 withPage:1];
    }];
    
    self.mainTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        self.currentPage = self.currentPage + 1;
        [((ExplorationViewController *)weakSelf.myViewController) loadPageDataWithType:self.currentIndex + 1 withPage:self.currentPage];
    }];
    
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[ExplorationViewDetailTableViewCell class] forCellReuseIdentifier:@"ExplorationViewDetailTableViewCell"];
    [self addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
        make.top.mas_equalTo(selectBar.mas_bottom).offset(2);
    }];
}

- (void)slideSelectBar:(LYSlideSelectBar *)slideSelectBar didSelectAnotherItemAtIndex:(NSUInteger)index{
    self.currentIndex = index;
    NSInteger paramIndex = 0;
    if (self.currentIndex == 0) {
        paramIndex = 1;
    }else if(self.currentIndex == 1){
        paramIndex = 2;
    }
    [((ExplorationViewController *)self.myViewController) loadPageDataWithType:paramIndex withPage:1];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExplorationViewDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ExplorationViewDetailTableViewCell"];
    cell.model = self.modelArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserMessageModel *model = self.modelArray[indexPath.row];
    if ([model.SEND_WAY isEqualToString:@"3"]) {
        RankDetailViewController *vc = [[RankDetailViewController alloc] initWithNewsTitles:model.MESSAGE_TITLE];
        vc.hidesBottomBarWhenPushed = YES;
        [self.myViewController.navigationController pushViewController:vc animated:YES];
    }else{
        MessageDetailViewController *vc = [[MessageDetailViewController alloc] initWithModel:model];
        vc.hidesBottomBarWhenPushed = YES;
        [self.myViewController.navigationController pushViewController:vc animated:YES];
    }
}
- (void)setModelArray:(NSArray *)modelArray{
    _modelArray = modelArray;
    [_mainTableView reloadData];
    if (modelArray.count == 0) {
        [Tool showNoDataPicOnView:self.mainTableView withImage:[UIImage imageNamed:@"无消息"] title:@"暂无消息" size:CGSizeMake(118, 144) topDistance:150];
    }else{
        [Tool hideNoDataPicOnView:self.mainTableView];
    }
}
@end
