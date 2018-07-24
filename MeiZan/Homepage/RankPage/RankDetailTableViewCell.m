//
//  RankDetailTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/15.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "RankDetailTableViewCell.h"
@interface RankDetailTableViewCell()
@property (nonatomic, strong) UIImageView *titleImg;
@property (nonatomic, strong) UIImageView *userIcon;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *normalRank;
@end
@implementation RankDetailTableViewCell
- (void)createSubview{
    self.titleImg = [[UIImageView alloc] init];
    [self.contentView addSubview:self.titleImg];
    [self.titleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).offset(23);
        make.width.mas_equalTo(23);
        make.height.mas_equalTo(41);
    }];
    
    self.normalRank = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@""];
    self.normalRank.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.normalRank];
    [self.normalRank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.bottom.mas_equalTo(self.titleImg);
    }];
    
    self.userIcon = [[UIImageView alloc] init];
    self.userIcon.layer.cornerRadius = 20;
    self.userIcon.layer.masksToBounds = YES;
    [self.contentView addSubview:self.userIcon];
    [self.userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(40);
        make.leading.mas_equalTo(self.titleImg.mas_trailing).offset(CUSTOM_WIDTH(8));
        make.centerY.mas_equalTo(self.contentView);
        }];
    
    self.nameLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@""];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.userIcon.mas_trailing).offset(CUSTOM_WIDTH(16));
        make.top.mas_equalTo(self.contentView).offset(15);
    }];
    
    self.amountLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@""];
    [self.contentView addSubview:self.amountLabel];
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.userIcon.mas_trailing).offset(CUSTOM_WIDTH(16));
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.bottom.trailing.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (void)setModel:(RankDetailModel *)model{
    _model = model;
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.PHOTO_URL] placeholderImage:[UIImage imageNamed:@"AppIcon"]];
    if (model.RANK.integerValue < 4) {
        self.titleImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"rank_%ld",model.RANK.integerValue]];
        self.normalRank.text = @"";
    }else{
        self.titleImg.image = nil;
        self.normalRank.text = [NSString stringWithFormat:@"%ld", model.RANK.integerValue];
    }
    self.nameLabel.text = model.NICK_NAME;
    self.amountLabel.text = [NSString stringWithFormat:@"¥%.2f元", model.TRANS_AMOUNT.floatValue];
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
