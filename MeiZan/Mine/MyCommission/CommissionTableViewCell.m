//
//  CommissionTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "CommissionTableViewCell.h"
@interface CommissionTableViewCell()
@property (nonatomic, strong) UILabel *tradeTitle;
@property (nonatomic, strong) UILabel *tradeTime;
@property (nonatomic, strong) UILabel *detail;
@property (nonatomic, strong) UILabel *status;
@end
@implementation CommissionTableViewCell
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
    
    self.status = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x62b900) text:@"成功"];
    [self.contentView addSubview:self.status];
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.detail.mas_bottom).offset(0);
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

- (void)setModel:(TradeRecordModel *)model{
    _model = model;
    _model = model;
    NSString *tempAccount;
    NSString *tempTransefer;
    switch (model.ACCOUNT_TYPE.intValue) {
        case 1:
            tempAccount = @"余额";
            break;
        case 2:
            tempAccount = @"积分";
            break;
        case 3:
            tempAccount = @"佣金";
            break;
        case 4:
            tempAccount = @"外部账户";
            break;
        default:
            break;
    }
    switch (model.TRANSFER_TYPE.intValue) {
        case 1:
            tempTransefer = @"充值";
            break;
        case 2:
            tempTransefer= @"提现";
            break;
        case 3:
           tempTransefer = @"支付";
            break;
        case 4:
            tempTransefer = @"奖励";
            break;
        case 5:
            tempTransefer = @"转出";
            break;
        default:
            break;
    }
    self.tradeTitle.text = [tempAccount stringByAppendingString:tempTransefer];
    if (model.MERCHANT_NAME != nil) {
          self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:[NSString stringWithFormat:@"(%@消费了%.2f元)",model.MERCHANT_NAME,model.PRICE.floatValue]];
    }
  
    self.tradeTime.text = model.CREATE_TIME;
    self.detail.text = [NSString stringWithFormat:@"%.2f元", fabsf(model.BALANCE.floatValue - model.PRE_BALANCE.floatValue)];

}
@end
