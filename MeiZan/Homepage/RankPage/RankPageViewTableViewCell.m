//
//  RankPageViewTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/15.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "RankPageViewTableViewCell.h"
@interface RankPageViewTableViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end
@implementation RankPageViewTableViewCell
- (void)createSubview{
    self.iconIMGV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconIMGV];
    [self.iconIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
    }];
    
    self.titleLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:TITLECOLOR text:@""];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(17);
        make.leading.mas_equalTo(self.iconIMGV.mas_trailing).offset(CUSTOM_WIDTH(14));
    }];
    
    self.detailLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@""];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(5);
        make.leading.mas_equalTo(self.iconIMGV.mas_trailing).offset(CUSTOM_WIDTH(14));
    }];
    
    UIImageView *arrow_Img = [[UIImageView alloc] init];
    arrow_Img.image = [UIImage imageNamed:@"rightArrow"];
    [self.contentView addSubview:arrow_Img];
    [arrow_Img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(8);
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
    }];
    
    UIView *inset_line = [[UIView alloc] init];
    inset_line.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:inset_line];
    [inset_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.bottom.trailing.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(CUSTOM_WIDTH(14));
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(UserMessageModel *)model{
    _model = model;
    self.titleLabel.text = model.MESSAGE_TITLE;
    self.detailLabel.text = [[NSString stringWithFormat:@"第一名  "] stringByAppendingString:model.MESSAGE_CONTENT];
}

@end
