//
//  MyCommissionView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyCommissionView.h"
#import "Mine_DetailTableViewCell.h"
#import "CommissionWithdrawViewController.h"
#import "CommissionRecordViewController.h"
@interface MyCommissionView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UILabel *merchantName;
@property (nonatomic, strong) UILabel *commissionLabel;
@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSArray *titleArray;
@end
@implementation MyCommissionView
- (void)createSubview{
    self.backgroundColor = COLOR_RGB16(0xfafafa);
    
    UIImageView *backGroundIMGV = [[UIImageView alloc] init];
    backGroundIMGV.image = [UIImage imageNamed:@"myCommissionBackgournd"];
    [self addSubview:backGroundIMGV];
    [backGroundIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(120);
    }];
    
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    self.merchantName = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:18] color:[UIColor whiteColor] text:config.userInfo.nickName];
    [self addSubview:self.merchantName];
    [self.merchantName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(34);
    }];
    
    UIView *commissionView = [[UIView alloc] init];
    commissionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:commissionView];
    commissionView.layer.shadowColor = COLOR_RGB16(0x666666).CGColor;
    commissionView.layer.shadowOffset = CGSizeMake(0, 2);
    commissionView.layer.shadowOpacity = 0.2;
    commissionView.layer.shadowRadius = 4;
    commissionView.layer.masksToBounds = NO;
    [commissionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backGroundIMGV.mas_bottom);
        make.width.mas_equalTo(CUSTOM_WIDTH(347));
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(78);
    }];
    
    self.commissionLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Medium" size:20] color:TITLECOLOR text:[NSString stringWithFormat:@"%.2f", config.userInfo.brokerage.floatValue]];
    [commissionView addSubview:self.commissionLabel];
    [self.commissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(commissionView);
        make.top.mas_equalTo(commissionView).offset(20);
    }];
    
    UILabel *const_commissionLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@"返利佣金(元)"];
    [commissionView addSubview:const_commissionLabel];
    [const_commissionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.mas_equalTo(commissionView);
        make.top.mas_equalTo(self.commissionLabel.mas_bottom).offset(10);
    }];
    
    self.mainTableView = [[UITableView alloc] init];
    [self addSubview:self.mainTableView];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.scrollEnabled = NO;
    [self.mainTableView registerClass:[Mine_DetailTableViewCell class] forCellReuseIdentifier:@"Mine_DetailTableViewCell"];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(commissionView.mas_bottom).offset(10);
        make.height.mas_equalTo(210);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Mine_DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mine_DetailTableViewCell"];
    cell.titleText = self.titleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:{
            vc = [[CommissionWithdrawViewController alloc] init];
            break;
        }
        case 1:{
            vc = [[CommissionRecordViewController alloc] initWithType:1];
            break;
        }
        case 2:{
            vc = [[CommissionRecordViewController alloc] initWithType:2];
            break;
        }
        default:
            break;
    }
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"转出余额",@"转出记录",@"佣金明细"];
    }
    return _titleArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
