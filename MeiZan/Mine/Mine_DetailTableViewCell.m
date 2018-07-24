//
//  Mine_DetailTableViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/8.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "Mine_DetailTableViewCell.h"
@interface Mine_DetailTableViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconIMGV;
@end
@implementation Mine_DetailTableViewCell
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
        make.centerY.mas_equalTo(self.contentView);
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


- (void)setTitleText:(NSString *)titleText{
    _titleLabel.text = titleText;
    if ([titleText containsString:@"店铺认证"]) {
        _iconIMGV.image = [UIImage imageNamed:@"店铺认证"];
    }else{
        _iconIMGV.image = [UIImage imageNamed:titleText];
    }
}
@end
