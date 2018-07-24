//
//  TradeRecordDetailTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "TradeRecordDetailTableViewCell.h"
@interface TradeRecordDetailTableViewCell()
@property (nonatomic, strong) UILabel *tradeTitle;
@property (nonatomic, strong) UILabel *tradeTime;
@property (nonatomic, strong) UILabel *detail;
@end
@implementation TradeRecordDetailTableViewCell
- (void)createSubview{
    self.detail = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:TITLECOLOR text:@""];
    self.detail.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.detail];
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(15);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
    }];
    
    self.tradeTitle = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"流水标题"];
    [self.contentView addSubview:self.tradeTitle];
    [self.tradeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self).offset(15);
        make.trailing.mas_equalTo(self.detail.mas_leading).offset(-3);
    }];
    
    self.tradeTime = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@"2017-08-07  22:43:16"];
    [self.contentView addSubview:self.tradeTime];
    [self.tradeTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.tradeTitle);
        make.bottom.mas_equalTo(-6);
    }];
    
    UILabel *stateLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x62B900) text:@"成功"];
    [self.contentView addSubview:stateLabel];
    [stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
          make.bottom.mas_equalTo(-6);
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
    switch (model.ACCOUNT_TYPE.intValue) {
        case 1:
            self.tradeTitle.text = @"余额";
            break;
        case 2:
            self.tradeTitle.text = @"积分";
            break;
        case 3:
            self.tradeTitle.text = @"佣金";
            break;
        case 4:
            self.tradeTitle.text = @"外部";
            break;
        default:
             self.tradeTitle.text = @"支付";
            break;
    }
    switch (model.ACCOUNT_TYPE.intValue) {
        case 1:
            self.tradeTitle.text = @"余额";
            break;
        case 2:
            self.tradeTitle.text = @"积分";
            break;
        case 3:
            self.tradeTitle.text = @"佣金";
            break;
        case 4:
            self.tradeTitle.text = @"外部";
            break;
        default:
            self.tradeTitle.text = @"支付";
            break;
    }
    switch (model.TRANSFER_TYPE.intValue) {
        case 1:
            self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:@"充值"];
            break;
        case 2:
            self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:@"提现"];
            break;
        case 3:
            self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:@"支付"];
            break;
        case 4:
            self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:@"奖励"];
            break;
        case 5:
            if ([self.tradeTitle.text isEqualToString:@"余额"]) {
                self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:@"转入"];
            }else{
                self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:@"转出"];
            }
            break;
        case 6:
            self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:@"下级代理分润"];
            break;
        case 7:
            self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:@"支付奖励积分"];
            break;
        case 8:
            self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:@"排名奖励积分"];
            break;
        case 9:
            self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:@"推荐人返佣"];
            break;
        case 10:
            self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:@"增值创收奖励积分"];
            break;
        case 11:
            self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:@"调账"];
            break;
        default:
            break;
    }
    if (model.MERCHANT_NAME != nil && model.MERCHANT_NAME.length != 0) {
        self.tradeTitle.text = [self.tradeTitle.text stringByAppendingString:[NSString stringWithFormat:@"(%@消费了%.2f元)",model.MERCHANT_NAME,model.PRICE.floatValue]];
    }
    self.tradeTitle.adjustsFontSizeToFitWidth=YES;
    self.tradeTime.text = model.CREATE_TIME;
    self.detail.text = [NSString stringWithFormat:@"%.2f元",model.BALANCE.floatValue - model.PRE_BALANCE.floatValue];
    if (model.BALANCE.floatValue - model.PRE_BALANCE.floatValue < 0) {
        self.detail.textColor = COLOR_RGB16(0xff0000);
    }else{
        self.detail.textColor = COLOR_RGB16(0x666666);
    }
    [self layoutIfNeeded];
}
@end
