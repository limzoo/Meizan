//
//  Mine_HeaderTableViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/8.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "Mine_HeaderTableViewCell.h"
#import "UserLoginViewController.h"
@interface Mine_HeaderTableViewCell()

@end
@implementation Mine_HeaderTableViewCell
- (void)createSubview{
    UIImageView *iconBackgroundIMGV = [[UIImageView alloc] init];
    iconBackgroundIMGV.userInteractionEnabled = YES;
    iconBackgroundIMGV.image = [UIImage imageNamed:@"mine_background"];
    [self.contentView addSubview:iconBackgroundIMGV];
    [iconBackgroundIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(180);
    }];
   self.iconImgView = [[UIImageView alloc] init];
    self.iconImgView.userInteractionEnabled = YES;
    self.iconImgView.backgroundColor = [UIColor grayColor];
    self.iconImgView.layer.cornerRadius = 30;
    self.iconImgView.layer.masksToBounds = YES;
    [iconBackgroundIMGV addSubview:self.iconImgView];
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
        make.top.mas_equalTo(iconBackgroundIMGV.mas_top).offset(58);
        make.leading.mas_equalTo(iconBackgroundIMGV.mas_leading).offset(CUSTOM_WIDTH(14));
    }];
    
    
    self.nameLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:COLOR_RGB16(0xffffff) text:nil];
    [iconBackgroundIMGV addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconImgView.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(iconBackgroundIMGV.mas_top).offset(66);
    }];
    
    self.detailLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:11] color:COLOR_RGB16(0xffffff) text:nil];
    self.detailLabel.textAlignment = NSTextAlignmentCenter;
    self.detailLabel.layer.cornerRadius = 2.0f;
    self.detailLabel.layer.borderWidth = 1;
    self.detailLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    [iconBackgroundIMGV addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLabel.mas_leading);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(8);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(CUSTOM_WIDTH(50));
    }];
    
    UIImageView  *scoreImgV = [[UIImageView alloc] init];
    scoreImgV.image = [UIImage imageNamed:@"mine_jifen"];
    [self.contentView addSubview:scoreImgV];
    [scoreImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(iconBackgroundIMGV);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(91);
        make.trailing.mas_equalTo(self.contentView);
    }];
    
    self.scoreLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:12] color:[UIColor whiteColor] text:nil];
    [self.contentView addSubview:self.scoreLabel];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(scoreImgV);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(11));
    }];
    self.scoreLabel.textAlignment = NSTextAlignmentRight;
    //中间那块
    
    UIView *middleView = [[UIView alloc] init];
    middleView.backgroundColor = [UIColor whiteColor];
    middleView.layer.shadowOffset = CGSizeMake(0, 2);
    middleView.layer.shadowColor = COLOR_RGB16(0x666666).CGColor;
    middleView.layer.shadowOpacity = 0.12;
    middleView.layer.shadowRadius = 4;
    middleView.layer.masksToBounds = NO;
    [self.contentView addSubview:middleView];
    [middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(iconBackgroundIMGV.mas_bottom);
        make.height.mas_equalTo(78);
        make.centerX.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
    }];
    
    UILabel *const_acount = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@"账户余额(元)"];
    [middleView addSubview:const_acount];
    [const_acount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(middleView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(middleView).offset(15);
    }];
    
    self.accountLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Medium" size:24] color:TITLECOLOR text:nil];
    [middleView addSubview:self.accountLabel];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(const_acount);
        make.bottom.mas_equalTo(middleView.mas_bottom).offset(-15);
    }];
    
    UIButton *chargeButton = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:4.0f fontSize:16 title:@"充值"];
    [chargeButton addTarget:self action:@selector(moveToChargePage:) forControlEvents:UIControlEventTouchUpInside];
    [middleView addSubview:chargeButton];
    [chargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(92));
        make.height.mas_equalTo(CUSTOM_HEIGHT(34));
        make.centerY.mas_equalTo(middleView);
        make.trailing.mas_equalTo(middleView).offset(-CUSTOM_WIDTH(12));
    }];
    chargeButton.layer.borderColor = STYLECOLOR.CGColor;
    chargeButton.layer.borderWidth = 1;
    chargeButton.layer.cornerRadius = 4;
    
    //下面的东西
    self.blockView = [[UIView alloc] init];
    self.blockView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.blockView];
    [self.blockView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(middleView.mas_bottom).offset(10);
        make.height.mas_equalTo(95);
    }];
    
    self.welcomeLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Semibold" size:20] color:[UIColor whiteColor] text:@"欢迎来到美赞"];
    [self.contentView addSubview:self.welcomeLabel];
    [self.welcomeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self).offset(52);
    }];
    
    self.loginButton = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.8/1.0] cornerRadius:4 fontSize:16 title:@"登录"];
    [self.contentView addSubview:self.loginButton];
    [self.loginButton addTarget:self action:@selector(moveToLoginAction) forControlEvents:UIControlEventTouchUpInside];
    self.loginButton.layer.borderColor = STYLECOLOR.CGColor;
    self.loginButton.layer.borderWidth = 1;
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.welcomeLabel);
        make.width.mas_equalTo(92);
        make.height.mas_equalTo(34);
        make.top.mas_equalTo(self.welcomeLabel.mas_bottom).offset(14);
    }];

}
- (void)createButtonWithTitlesArray:(NSArray *)titleArray{
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:12 title:titleArray[i]];
        [button setImage:[UIImage imageNamed:titleArray[i]] forState:UIControlStateNormal];
        button.tag = 100 + i;
        button.frame = CGRectMake(i * self.contentView.bounds.size.width / 5, 0, self.contentView.bounds.size.width / 5, 94);
        [button setImageEdgeInsets:UIEdgeInsetsMake(-button.titleLabel.intrinsicContentSize.height, 0, 0, -button.titleLabel.intrinsicContentSize.width)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(button.currentImage.size.height, -button.currentImage.size.width, -10, 0)];
        [self.blockView addSubview:button];
        [button addTarget:self action:@selector(moveToMyOrderPage:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)moveToLoginAction{
    UserLoginViewController *vc =[[UserLoginViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}
- (void)moveToMyOrderPage:(UIButton *)sender{
    NSInteger index = (sender.tag - 100) + 1;//因为前面加了个 "全部"
    self.moveToMyOrderPage(index);
}
- (void)moveToChargePage:(UIButton *)sender{
    self.moveToChargePage();
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
