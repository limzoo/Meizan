//
//  AccountSettingView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "AccountSettingView.h"
#import "LeftRightLabelTableViewCell.h"
#import "AddressManageViewController.h"
#import "UpdateNickNameViewController.h"
#import "AccountSettingViewController.h"
#import "ResetPasswordViewController.h"
#import "SetPayPasswordViewController.h"
#import "VerifyUserViewController.h"
@interface AccountSettingView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *titlesArray;
@property (nonatomic, strong) UITableView *mainTableView;
@end
@implementation AccountSettingView
- (void)createSubview{
    self.backgroundColor = COLOR_RGB16(0xfafafa);
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self.mainTableView registerClass:[LeftRightLabelTableViewCell class] forCellReuseIdentifier:@"LeftRightLabelTableViewCell"];
    self.mainTableView.scrollEnabled = NO;
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(48 * 4);
    }];
    
    UIButton *logOut = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4.0f fontSize:16 title:@"退出登录"];
    [logOut addTarget:self action:@selector(logOutAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:logOut];
    [logOut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-11);
    }];
}

- (void)logOutAction:(UIButton *)sender{
    [((AccountSettingViewController *)self.myViewController) logOut];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftRightLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftRightLabelTableViewCell"];
    cell.leftLabel.text = self.titlesArray[indexPath.row];
    cell.hasArrow = YES;
    cell.rightLabel = nil;
    cell.leftLabel.textColor = TITLECOLOR;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (NSArray *)titlesArray{
    if (!_titlesArray) {
        _titlesArray = @[@"修改昵称",@"修改登录密码",@"修改交易密码",@"地址管理"];
    }
    return _titlesArray;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            UpdateNickNameViewController *vc = [[UpdateNickNameViewController alloc] init];
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:{
            ResetPasswordViewController *vc = [[ResetPasswordViewController alloc] init];
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            VerifyUserViewController *vc = [[VerifyUserViewController alloc] init];
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:{
           AddressManageViewController *vc = [[AddressManageViewController alloc] init];
            vc.shouldSelectBack = NO;
            vc.backAddressModel = ^(UserAddressModel *model) {
                ;
            };
             [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
