//
//  ChargeRecordTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/31.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ChargeRecordTableViewCell.h"
@interface ChargeRecordTableViewCell()
@property (nonatomic, strong) UILabel *tradeTitle;
@property (nonatomic, strong) UILabel *tradeTime;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UILabel *status;
@end
@implementation ChargeRecordTableViewCell
- (void)createSubview{
    self.tradeTitle = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"流水标题"];
    [self.contentView addSubview:self.tradeTitle];
    [self.tradeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self).offset(15);
    }];
    
    self.tradeTime = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@"2017-08-07  22:43:16"];
    [self.contentView addSubview:self.tradeTime];
    [self.tradeTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.tradeTitle);
        make.bottom.mas_equalTo(-6);
    }];
    
    self.detail = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:TITLECOLOR text:@""];
    [self.contentView addSubview:self.detail];
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(14);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
    }];
    
    self.status = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x62b900) text:@""];
    [self.contentView addSubview:self.status];
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detail.mas_bottom).offset(0);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(ChargeRecordModel *)model{
    _model = model;
    switch (model.PAYMENT_WAY.integerValue) {
        case 1:
            self.tradeTitle.text = @"微信充值";
            break;
        case 2:
            self.tradeTitle.text = @"支付宝充值";
            break;
        case 4:
            self.tradeTitle.text = @"线下充值";
            break;
            break;default:
            break;
    }
    switch (model.ORDER_STATUS.integerValue) {
        case 0:
            self.status.text = @"待支付";
            break;
        case 1:
            self.status.text = @"已支付";
            break;
        case 2:
            self.status.text = @"已发货";
            break;
        case 3:
            self.status.text = @"已确认";
            break;
        case 4:
            self.status.text = @"已评价";
            break;
        case 5:
            self.status.text = @"已取消";
            break;
        case 6:
            self.status.text = @"待审核";
            break;
        default:
            break;
    }
    self.tradeTime.text = model.CREATE_TIME;
    self.detail.text = [NSString stringWithFormat:@"%.2f元", model.RECHARGE_AMOUNT.floatValue];
    
}
@end
