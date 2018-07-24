//
//  HP_ScrollingTitleCollectionViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2017/12/25.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "HP_ScrollingTitleCollectionViewCell.h"
#import "ScrollingTableViewCell.h"
#import "RankDetailViewController.h"
#import "RankDetailModel.h"
@interface HP_ScrollingTitleCollectionViewCell()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *titleTableView;
@property (nonatomic, strong) NSTimer *scrollTimer;

@end
@implementation HP_ScrollingTitleCollectionViewCell
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    UILabel *const_titleLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"ZoomlaYasong-A001" size:14] color:STYLECOLOR text:@"排行榜 |"];
    [self.contentView addSubview:const_titleLabel];
    [const_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
    }];
    
    self.arrowIMGV = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.arrowIMGV setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.arrowIMGV];
    [self.arrowIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.top.bottom.mas_equalTo(self);
        make.width.mas_equalTo(CUSTOM_WIDTH(50));
    }];
    
    self.titleTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.titleTableView.backgroundColor = [UIColor whiteColor];
    self.titleTableView.contentOffset = CGPointMake(0, 50);
    self.titleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.titleTableView registerClass:[ScrollingTableViewCell class] forCellReuseIdentifier:@"ScrollingTableViewCell"];
    self.titleTableView.pagingEnabled = YES;
    self.titleTableView.showsVerticalScrollIndicator = NO;
    self.titleTableView.delegate = self;
    self.titleTableView.dataSource = self;
    [self.contentView addSubview:self.titleTableView];
    [self.titleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(const_titleLabel.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.trailing.mas_equalTo(self.arrowIMGV.mas_leading);
    }];
}

- (void)scrollTableView:(NSTimer *)sender{
    CGPoint contentOffset;
    contentOffset = CGPointMake(0, 50 + self.titleTableView.contentOffset.y);
    [self.titleTableView setContentOffset:contentOffset animated:YES];
    NSLog(@"%f",contentOffset.y);
    NSLog(@"%@",sender);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //纠正滚动残余,似乎没什么用
    if ((int)scrollView.contentOffset.y % 50 != 0.0) {
        NSInteger page;
        if (((int)scrollView.contentOffset.y % 50)/50 > 0.5) {
            page = scrollView.contentOffset.y / 50 + 1;
        }else{
            page = scrollView.contentOffset.y / 50;
        }
        [scrollView setContentOffset:CGPointMake(0, (page + 1) * 50) animated:NO];
        return;
    }

    if (self.titleTableView.contentOffset.y >= 50.00 + self.newsArray.count * 50) {//200是所有cell的总高度
        [self.titleTableView setContentOffset:CGPointMake(0, 50) animated:NO];
        return;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.scrollTimer invalidate];
    self.scrollTimer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.scrollTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollTableView:) userInfo:nil repeats:YES];
      [[NSRunLoop mainRunLoop] addTimer:self.scrollTimer forMode:NSRunLoopCommonModes];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.newsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScrollingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScrollingTableViewCell"];
    UserMessageModel *model = self.newsArray[indexPath.row];
        cell.newsTitle = model.MESSAGE_TITLE;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(footMoveToFirstDetail:)]];
    UILabel *newsLabel = [[UILabel alloc] init];
    [view addSubview:newsLabel];
    newsLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    UserMessageModel *model = [self.newsArray firstObject];
    if (self.newsArray.count == 0) {
        newsLabel.text = @"暂无排名";
    }else{
        newsLabel.text =  [NSString stringWithFormat:@"·  %@",model.MESSAGE_TITLE];
    }
    [newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.trailing.mas_equalTo(view);
    }];
    return view;
}
- (void)footMoveToFirstDetail:(UITapGestureRecognizer *)rec{
    UserMessageModel *model = [self.newsArray firstObject];
    if (model) {
        RankDetailViewController *vc = [[RankDetailViewController alloc] initWithNewsTitles:model.MESSAGE_TITLE];
        vc.hidesBottomBarWhenPushed = YES;
        [self.myViewcontroller.navigationController pushViewController:vc animated:YES];
    }else{
        [[Tool getCurrentVC].view performSelector:@selector(moveToRankPage:) withObject:nil afterDelay:0];
    }
}

- (void)headMoveToLastDetail:(UITapGestureRecognizer *)rec{
    UserMessageModel *model = [self.newsArray lastObject];
    if (model) {
        RankDetailViewController *vc = [[RankDetailViewController alloc] initWithNewsTitles:model.MESSAGE_TITLE];
        vc.hidesBottomBarWhenPushed = YES;
        [self.myViewcontroller.navigationController pushViewController:vc animated:YES];
    }else{
          [[Tool getCurrentVC].view performSelector:@selector(moveToRankPage:) withObject:nil afterDelay:0];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headMoveToLastDetail:)]];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *newsLabel = [[UILabel alloc] init];
    [view addSubview:newsLabel];
    UserMessageModel *model = [self.newsArray lastObject];
    if (self.newsArray.count == 0) {
        newsLabel.text = @"暂无排名";
    }else{
        newsLabel.text =  [NSString stringWithFormat:@"·  %@",model.MESSAGE_TITLE];
    }
    newsLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.trailing.mas_equalTo(view);
    }];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserMessageModel *model = self.newsArray[indexPath.row];
    RankDetailViewController *vc = [[RankDetailViewController alloc] initWithNewsTitles:model.MESSAGE_TITLE];
    vc.hidesBottomBarWhenPushed = YES;
    [self.myViewcontroller.navigationController pushViewController:vc animated:YES];
}

- (void)setNewsArray:(NSMutableArray *)newsArray{
    _newsArray = [NSMutableArray arrayWithArray:newsArray];
    [_titleTableView reloadData];
}

- (void)createScrollTimer{
    if(!self.scrollTimer){
        self.scrollTimer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(scrollTableView:) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.scrollTimer forMode:NSRunLoopCommonModes];
    }
}

@end
