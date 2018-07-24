//
//  LeftImageTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/2.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "LeftImageTableViewCell.h"

@interface LeftImageTableViewCell()

@end
@implementation LeftImageTableViewCell
- (void)createSubview{
    self.titleImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.titleImgView];
    [self.titleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(32);
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
    }];
    
    self.titleLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@""];
    self.titleLabel.numberOfLines = 0;
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.titleImgView.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(10));
    }];
    
    self.selectImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.selectImgView];
    [self.selectImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(18);
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
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

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = title;
    self.titleImgView.image = [UIImage imageNamed:title];
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    if ([title isEqualToString:@"余额"] && config) {
        self.titleLabel.text = [title stringByAppendingString:[NSString stringWithFormat:@"(¥%.2f) 积分(%.2f)",config.userInfo.balance.floatValue, config.userInfo.integral.floatValue]];
    }
}
@end
