//
//  LeftLabelRightTextfieldTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/9.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "LeftLabelRightTextfieldTableViewCell.h"

@implementation LeftLabelRightTextfieldTableViewCell
- (void)createSubview{
    self.leftLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:nil];
    [self.contentView addSubview:self.leftLabel];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
    }];
    
    self.rightTextField = [[UITextField alloc] init];
    [self.contentView addSubview:self.rightTextField];
    [self.rightTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        make.width.mas_equalTo(CUSTOM_WIDTH(150));
        make.height.mas_equalTo(20);
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
