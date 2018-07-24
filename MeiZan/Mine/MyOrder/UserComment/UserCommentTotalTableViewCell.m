//
//  UserCommentTotalTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UserCommentTotalTableViewCell.h"
#import "RatingBar.h"
@interface UserCommentTotalTableViewCell()
@property (nonatomic, strong) UIImageView *anonymitySelectIMGV;
@end
@implementation UserCommentTotalTableViewCell
- (void)createSubview{
    self.anonymityView = [[UIView alloc] init];
    [self.contentView addSubview:self.anonymityView];
    self.anonymityView.backgroundColor = [UIColor whiteColor];
    [self.anonymityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
    
    self.anonymitySelectIMGV = [[UIImageView alloc] init];
    self.anonymitySelectIMGV.image = [UIImage imageNamed:@"nick_unselect"];
    [self.anonymityView addSubview:self.anonymitySelectIMGV];
    [self.anonymitySelectIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.anonymityView).offset(CUSTOM_WIDTH(14));
        make.width.height.mas_equalTo(18);
        make.centerY.mas_equalTo(self.anonymityView);
    }];
    
    UILabel *const_anonymity = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"匿名"];
    [self.anonymityView addSubview:const_anonymity];
    [const_anonymity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.anonymitySelectIMGV.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(self.anonymityView);
    }];
    
    UILabel *const_anonymityDetail = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x999999) text:@"你写的评价会以匿名的形式展现"];
    [self.anonymityView addSubview:const_anonymityDetail];
    [const_anonymityDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.anonymityView).offset(-CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(self.anonymityView);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.anonymityView.mas_bottom);
    }];
    
    UIImageView *const_shopIMGV = [[UIImageView alloc] init];
    const_shopIMGV.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:const_shopIMGV];
    [const_shopIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(lineView.mas_bottom).offset(11);
        make.width.height.mas_equalTo(16);
    }];
    
    UILabel *const_dianpupingfen = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"店铺评分"];
    [self addSubview:const_dianpupingfen];
    [const_dianpupingfen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(const_shopIMGV.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(const_shopIMGV);
    }];
    
    UILabel *const_miaoshuxiaofu = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"描述相符"];
    [self addSubview:const_miaoshuxiaofu];
    [const_miaoshuxiaofu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(const_shopIMGV.mas_bottom).offset(23);
    }];
    
    self.rateBar_1 = [[RatingBar alloc] initWithFrame:CGRectMake(0, 0, 148, 20) unselected_imageName:@"star_gray" selected_imageName:@"star_yellow"];
//    self.goodsScore = [NSString stringWithFormat:@"%ld",rateBar_1.starNumber];
    self.rateBar_1.starNumber = 5;
    [self addSubview:self.rateBar_1];
    [self.rateBar_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(const_miaoshuxiaofu.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(const_miaoshuxiaofu);
        make.width.mas_equalTo(148);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *const_wuliufuwu = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"物流服务"];
    [self addSubview:const_wuliufuwu];
    [const_wuliufuwu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(const_miaoshuxiaofu.mas_bottom).offset(28);
    }];
    
    self.rateBar_2 = [[RatingBar alloc] initWithFrame:CGRectMake(0, 0, 148, 20) unselected_imageName:@"star_gray" selected_imageName:@"star_yellow"];
     self.rateBar_2.starNumber = 5;
    [self addSubview:self.rateBar_2];
    [self.rateBar_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(const_wuliufuwu.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(const_wuliufuwu);
        make.width.mas_equalTo(148);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *const_fuwutaidu = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"服务态度"];
    [self addSubview:const_fuwutaidu];
    [const_fuwutaidu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(const_wuliufuwu.mas_bottom).offset(28);
    }];
    
  
    
    self.rateBar_3 = [[RatingBar alloc] initWithFrame:CGRectMake(0, 0, 148, 20) unselected_imageName:@"star_gray" selected_imageName:@"star_yellow"];
     self.rateBar_3.starNumber = 5;
    [self addSubview:self.rateBar_3];
    [self.rateBar_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(const_fuwutaidu.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(const_fuwutaidu);
        make.width.mas_equalTo(148);
        make.height.mas_equalTo(20);
    }];
    
    self.confirmButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4 fontSize:16 title:@"确认"];
    [self addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(const_fuwutaidu.mas_bottom).offset(20);
    }];
    
}
- (void)setIsAnony:(BOOL)isAnony{
    _isAnony = isAnony;
    if (isAnony) {
        self.anonymitySelectIMGV.image = [UIImage imageNamed:@"nick_select"];
    }else{
        self.anonymitySelectIMGV.image = [UIImage imageNamed:@"nick_unselect"];
    }
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
