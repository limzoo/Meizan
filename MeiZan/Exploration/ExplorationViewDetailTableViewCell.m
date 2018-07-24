//
//  ExplorationViewDetailTableViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/20.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "ExplorationViewDetailTableViewCell.h"
@interface ExplorationViewDetailTableViewCell()
@property (nonatomic, strong) UIImageView *userIconIMGV;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UILabel *commitTimeLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *redPoint;
@end
@implementation ExplorationViewDetailTableViewCell
- (void)createSubview{
    self.userIconIMGV = [[UIImageView alloc] init];
    self.userIconIMGV.image = [UIImage imageNamed:@"AppIcon"];
    [self.contentView addSubview:self.userIconIMGV];
    [self.userIconIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(44);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.contentView).offset(18);
    }];
    
    self.redPoint = [[UIView alloc] init];
    self.redPoint.backgroundColor = COLOR_RGB16(0xff4239);
    self.redPoint.layer.cornerRadius = 4;
    self.redPoint.layer.masksToBounds = YES;
    [self.contentView addSubview:self.redPoint];
    [self.redPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(8);
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(20));
        make.top.mas_equalTo(self).offset(20);
    }];
    
    self.userNameLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@""];
    [self.contentView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.userIconIMGV.mas_trailing).offset(CUSTOM_WIDTH(16));
        make.top.mas_equalTo(self.contentView).offset(18);
        make.trailing.mas_equalTo(self.redPoint.mas_leading).offset(CUSTOM_WIDTH(10));
    }];
    
    self.detailLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:STYLECOLOR text:@"点击查看详情..."];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.userNameLabel);
        make.bottom.mas_equalTo(self.userIconIMGV.mas_bottom).offset(5);
    }];
    
    self.commitTimeLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x9b9b9b) text:@"2018-12-26"];
    [self.contentView addSubview:self.commitTimeLabel];
    [self.commitTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
        make.bottom.mas_equalTo(self.detailLabel);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_RGB16(0xe5e5e5);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(14);
        make.height.mas_equalTo(1);
        make.bottom.trailing.mas_equalTo(self.contentView);
    }];
    
  
    
}

- (void)setModel:(UserMessageModel *)model{
    _model = model;
//    [_userIconIMGV sd_setImageWithURL:[NSURL URLWithString:model.MESSAGE_IMG]];
    _userNameLabel.text = model.MESSAGE_TITLE;
    _commitTimeLabel.text = model.CREATE_TIME;
    if ([model.IS_READ isEqualToString:@"0"]) {
        self.redPoint.hidden = NO;
    }else{
          self.redPoint.hidden = YES;
    }
    /*@property (nonatomic, strong) UIImageView *userIconIMGV;
     @property (nonatomic, strong) UILabel *userNameLabel;
     @property (nonatomic, strong) UILabel *commitTimeLabel;
     @property (nonatomic, strong) UILabel *detailLabel;*/
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
