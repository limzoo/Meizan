//
//  MineView.m
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MineView.h"
#import "Mine_HeaderTableViewCell.h"
#import "Mine_DetailTableViewCell.h"
#import "ChargeViewController.h"
#import "AccountSettingViewController.h"
#import "TradeRecordViewController.h"
#import "MyOrderViewController.h"
#import "MyCommissionViewController.h"
#import "MerchantAuthorizeViewController.h"
#import "MyAgentViewController.h"
#import "AboutMeizanViewController.h"
#import "UserFeedbViewController.h"
#import "UserLoginViewController.h"
#import "ShareViewController.h"
@interface MineView()<UITableViewDelegate, UITableViewDataSource>

@end
@implementation MineView
#pragma mark - <tableView>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 8;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 330;
            break;
        case 1:
            return 70;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            Mine_HeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mine_HeaderTableViewCell" forIndexPath:indexPath];
            cell.myViewController = self.myViewController;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
            if (config != nil) {
                if (config.userInfo.photoUrl != nil && config.userInfo.photoUrl.length != 0) {
                     [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:config.userInfo.photoUrl] placeholderImage:[UIImage imageNamed:@"AppIcon"]];
                }else{
//                [cell.iconImgView sd_setImageWithURL:[NSURL URLWithString:config.userInfo.photoUrl] placeholderImage:[UIImage imageNamed:@"AppIcon"]];
                    cell.iconImgView.image = [UIImage imageNamed:@"AppIcon"];
                }
                cell.nameLabel.text = config.userInfo.nickName;
                cell.detailLabel.text = config.levelName;
                cell.scoreLabel.text = [NSString stringWithFormat:@"%ld 积分",(long)config.userInfo.integral.integerValue];
                cell.accountLabel.text = [NSString stringWithFormat:@"%.2f", config.userInfo.balance.floatValue];
                cell.moveToChargePage = ^{
                    ChargeViewController *vc = [[ChargeViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.myViewController.navigationController pushViewController:vc animated:YES];
                };
                [cell.iconImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToAccountSettingPage)]];
                cell.iconImgView.hidden = NO;
                cell.nameLabel.hidden = NO;
                cell.detailLabel.hidden = NO;
                cell.welcomeLabel.hidden = YES;
                cell.loginButton.hidden = YES;//cell控件hidden无效
            }else{
                cell.scoreLabel.text = [NSString stringWithFormat:@"****积分"];
                cell.accountLabel.text = [NSString stringWithFormat:@"****"];
                cell.moveToChargePage = ^{
                    UserLoginViewController *vc = [[UserLoginViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.myViewController.navigationController pushViewController:vc animated:YES];
                };
                cell.iconImgView.hidden = YES;
                cell.nameLabel.hidden = YES;
                cell.detailLabel.hidden = YES;
                cell.welcomeLabel.hidden = NO;
                cell.loginButton.hidden = NO;
            }
            [cell createButtonWithTitlesArray:@[@"待付款",@"待审核",@"待发货",@"待评价",@"待收货"]];
            cell.moveToMyOrderPage = ^(NSInteger currentIndex) {
                MyOrderViewController *vc = [[MyOrderViewController alloc] initWithIndex:currentIndex];
                vc.hidesBottomBarWhenPushed = YES;
                [self.myViewController.navigationController pushViewController:vc animated:YES];
            };
            return cell;
            break;
        }
        case 1:{
            Mine_DetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mine_DetailTableViewCell" forIndexPath:indexPath];
            cell.titleText = self.titleArray[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            break;
        }
            
        default:
            break;
    }
    return nil;
}
- (void)moveToAccountSettingPage{
    AccountSettingViewController *vc = [[AccountSettingViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return;
    }
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    if (!config) {
        UserLoginViewController *vc = [[UserLoginViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.myViewController.navigationController pushViewController:vc animated:YES];
        return;
    }
    UIViewController *vc;
    switch (indexPath.row) {
        case 0:{
            vc = [[TradeRecordViewController alloc] init];
            break;
        }
        case 1:
            vc = [[MyCommissionViewController alloc] init];
            break;
        case 2:
            vc = [[MerchantAuthorizeViewController alloc] init];
            break;
        case 3:
            vc = [[MyAgentViewController alloc] init];
            break;
        case 4:
            vc = [[ShareViewController alloc] init];
            break;
        case 5:
            vc = [[AccountSettingViewController alloc] init];
            
            break;
        case 6:
            vc = [[AboutMeizanViewController alloc] init];
            
            break;
        case 7:
            vc = [[UserFeedbViewController alloc] init];
            break;
        default:
            break;
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}
- (void)createSubview{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.mainTableView.showsVerticalScrollIndicator = NO;
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableView registerClass:[Mine_HeaderTableViewCell class] forCellReuseIdentifier:@"Mine_HeaderTableViewCell"];
    [self.mainTableView registerClass:[Mine_DetailTableViewCell class] forCellReuseIdentifier:@"Mine_DetailTableViewCell"];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self);
        make.top.mas_equalTo(self);
    }];
    if (@available(iOS 11.0, *)) {
        self.mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
}
- (NSArray *)titleArray{
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    if([config.userInfo.authenticationStatus isEqualToString:@"0"] || [config.userInfo.authenticationStatus isEqualToString:@"2"]){
        _titleArray = @[@"交易流水",@"我的佣金",@"店铺认证(未认证)",@"代理商",@"我要推荐",@"账户设置",@"关于我们",@"客户信息反馈"];
    }else if([config.userInfo.authenticationStatus isEqualToString:@"1"]){
        _titleArray = @[@"交易流水",@"我的佣金",@"店铺认证(已认证)",@"代理商",@"我要推荐",@"账户设置",@"关于我们",@"客户信息反馈"];
    }else{
        _titleArray = @[@"交易流水",@"我的佣金",@"店铺认证",@"代理商",@"我要推荐",@"账户设置",@"关于我们",@"客户信息反馈"];
    }
    return _titleArray;
}


- (void)refreshViewData{
    [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}
@end
