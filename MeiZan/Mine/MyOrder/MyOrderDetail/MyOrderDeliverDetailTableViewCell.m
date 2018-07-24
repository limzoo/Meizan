//
//  MyOrderDeliverDetailTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/24.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyOrderDeliverDetailTableViewCell.h"
@interface MyOrderDeliverDetailTableViewCell()

@end
@implementation MyOrderDeliverDetailTableViewCell
- (void)createSubview{
    UILabel *const_kuaidixinxi = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"快递信息"];
    [self.contentView addSubview:const_kuaidixinxi];
    [const_kuaidixinxi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self).offset(20);
    }];
    
    self.deliverMsg = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x999999) text:@""];
    [self.contentView addSubview:self.deliverMsg];
    [self.deliverMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(const_kuaidixinxi.mas_trailing).offset(CUSTOM_WIDTH(8));
        make.centerY.mas_equalTo(const_kuaidixinxi);
    }];
    
    self.delieverTime = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x999999) text:@""];
    [self.contentView addSubview:self.delieverTime];
    [self.delieverTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.deliverMsg);
        make.top.mas_equalTo(self.deliverMsg).offset(13);
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
