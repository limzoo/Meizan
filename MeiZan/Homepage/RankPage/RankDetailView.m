//
//  RankDetailView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/15.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "RankDetailView.h"
#import "RankDetailTableViewCell.h"
@interface RankDetailView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView *userIcon;
@property (nonatomic, strong) UILabel *userAmountLabel;
@property (nonatomic, strong) UILabel *rankName;
@property (nonatomic, strong) UITableView *tableView;
@end
@implementation RankDetailView
- (void)createSubview{
    
    self.backgroundColor = COLOR_RGB16(0xfafafa);
    
    UIImageView *backGroundImg = [[UIImageView alloc] init];
    backGroundImg.image = [UIImage imageNamed:@"mine_background"];
    backGroundImg.userInteractionEnabled = YES;
    [self addSubview:backGroundImg];
    [backGroundImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(130);
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"白返回键"] forState:0];
    [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [backGroundImg addSubview:backButton];
    
    self.titleLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:18] color:[UIColor whiteColor] text:@""];
    [backGroundImg addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(33);
    }];
    
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(50);
        make.leading.mas_equalTo(self);
        make.centerY.mas_equalTo(self.titleLabel);
    }];
    
    UIView *mineView = [[UIView alloc] init];
    mineView.backgroundColor = [UIColor whiteColor];
    mineView.layer.masksToBounds = NO;
    mineView.layer.shadowColor = COLOR_RGB16(0x666666).CGColor;
    mineView.layer.shadowOffset = CGSizeMake(0, 2);
    mineView.layer.shadowRadius = 4;
    mineView.layer.shadowOpacity = 0.2;
    [self addSubview:mineView];
    [self bringSubviewToFront:mineView];
    [mineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.height.mas_equalTo(128);
        make.top.mas_equalTo(self).offset(90);
    }];
    
    self.userIcon = [[UIImageView alloc] init];
    self.userIcon.layer.cornerRadius = 40;
    self.userIcon.layer.masksToBounds = YES;
    [mineView addSubview:self.userIcon];
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:config.userInfo.photoUrl] placeholderImage:[UIImage imageNamed:@"AppIcon"]];
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(mineView);
        make.height.width.mas_equalTo(80);
        make.top.mas_equalTo(mineView).offset(24);
    }];
    
    self.userAmountLabel = [[UILabel alloc] init];
    [self addSubview:self.userAmountLabel];
    [self.userAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.userIcon);
        make.leading.mas_equalTo(mineView).offset(40);
    }];
    
    self.rankName = [[UILabel alloc] init];
    self.rankName.text = @"暂无排名";
    [self addSubview:self.rankName];
    [self.rankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.userIcon);
        make.trailing.mas_equalTo(mineView).offset(-40);
    }];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:self.tableView];
    [self.tableView registerClass:[RankDetailTableViewCell class] forCellReuseIdentifier:@"RankDetailTableViewCell"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
        make.top.mas_equalTo(mineView.mas_bottom).offset(14);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.rankArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankDetailTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.rankArray[indexPath.row];
    return cell;
}
- (void)setUserRank:(long)userRank{
    _userRank = userRank;
    self.rankName.text = [NSString stringWithFormat:@"%ld名",userRank];
}
- (void)setRankArray:(NSMutableArray *)rankArray{
    _rankArray = rankArray;
    [self.tableView reloadData];
}

- (void)setUserAmount:(long)userAmount{
    _userAmount = userAmount;
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    NSString *tempStr;
    for (RankDetailModel *model in self.rankArray) {
        if (model.USER_ID.longValue == config.userInfo.userId) {
           tempStr = [NSString stringWithFormat:@"¥%.2f元",model.TRANS_AMOUNT.floatValue];
            break;
        }
    }
    if (tempStr) {
        self.userAmountLabel.text = tempStr;
    }else{
        self.userAmountLabel.text = [NSString stringWithFormat:@"¥%.2f元",userAmount/1.0];
    }
}

- (void)backAction{
    [self.myViewController.navigationController popViewControllerAnimated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
