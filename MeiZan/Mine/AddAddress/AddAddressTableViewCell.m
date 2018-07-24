//
//  AddAddressTableViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/15.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "AddAddressTableViewCell.h"
@interface AddAddressTableViewCell()
@end
@implementation AddAddressTableViewCell
- (void)createSubview{
    self.iconIMGV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconIMGV];
    [self.iconIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(self.contentView);
        make.width.mas_equalTo(16);
        make.height.mas_equalTo(16);
    }];
    self.arrowImgView = [[UIImageView alloc] init];
    self.arrowImgView.image = [UIImage imageNamed:@"rightArrow"];
    [self.contentView addSubview:self.arrowImgView];
    [self.arrowImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
    }];
    
    self.inputTextField = [[UITextField alloc] init];
    [self.contentView addSubview:self.inputTextField];
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.iconIMGV.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(self.arrowImgView.mas_leading).offset(-CUSTOM_WIDTH(14));
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

- (void)setHasArrow:(BOOL)hasArrow{
    _hasArrow = hasArrow;
    if (hasArrow) {
        self.arrowImgView.hidden = NO;
    }else{
        self.arrowImgView.hidden = YES;
    }
}
@end
