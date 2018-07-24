//
//  PayStyleSelectTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "PayStyleSelectTableViewCell.h"
@interface PayStyleSelectTableViewCell()
@property (nonatomic, strong) UIImageView *iconIMGV;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *selectNick;
@end
@implementation PayStyleSelectTableViewCell
- (void)configInitial{
    self.isSelected = NO;
}

- (void)createSubview{
    self.iconIMGV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconIMGV];
    [self.iconIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(32);
        make.height.mas_equalTo(32);
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
    }];
    
    self.titleLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@""];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.iconIMGV.mas_trailing).offset(CUSTOM_WIDTH(14));
    }];
    
    self.selectNick = [[UIImageView alloc] init];
    self.selectNick.image = [UIImage imageNamed:@"nick_unselect"];
    [self.contentView addSubview:self.selectNick];
    [self.selectNick mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.height.width.mas_equalTo(18);
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

- (void)setTitleText:(NSString *)titleText{
    _titleLabel.text = titleText;
    _iconIMGV.image = [UIImage imageNamed:titleText];
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (isSelected) {
        _selectNick.image = [UIImage imageNamed:@"nick_select"];
    }else{
            _selectNick.image = [UIImage imageNamed:@"nick_unselect"];
        }
}
@end
