//
//  UploadPicTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UploadPicTableViewCell.h"
@interface UploadPicTableViewCell()
@end
@implementation UploadPicTableViewCell
- (void)createSubview{
    self.titleLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@""];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
    }];
    
    self.imageViewOne = [[UIImageView alloc] init];
//    self.imageViewOne
    self.imageViewOne.userInteractionEnabled = YES;
    [self.contentView addSubview:self.imageViewOne];
    [self.imageViewOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(72);
        make.leading.mas_equalTo(self.contentView).offset(112);
    }];
    
    self.imageViewTwo = [[UIImageView alloc] init];
       self.imageViewTwo.userInteractionEnabled = YES;
    [self.contentView addSubview:self.imageViewTwo];
    [self.imageViewTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.width.height.mas_equalTo(72);
        make.leading.mas_equalTo(self.imageViewOne.mas_trailing).offset(20);
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

@end
