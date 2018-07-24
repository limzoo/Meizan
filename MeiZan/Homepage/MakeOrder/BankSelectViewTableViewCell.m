//
//  BankSelectViewTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/17.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BankSelectViewTableViewCell.h"
@interface BankSelectViewTableViewCell()
@property (nonatomic, strong) UIImageView *bankImgView;
@property (nonatomic, strong) UILabel *bankName;
@property (nonatomic, strong) UILabel *bankCardNo;

@end
@implementation BankSelectViewTableViewCell
- (void)createSubview{
    self.bankImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.bankImgView];
    [self.bankImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.width.height.mas_equalTo(32);
                                                    
    }];
    
    self.bankName = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@""];
    [self.contentView addSubview:self.bankName];
    [self.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(12);
        make.leading.mas_equalTo(self.bankImgView.mas_trailing).offset(CUSTOM_WIDTH(14));
    }];
    
    self.bankCardNo =  [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TITLECOLOR text:@""];
    [self.contentView addSubview:self.bankCardNo];
    [self.bankCardNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.bankName);
        make.top.mas_equalTo(self.bankName.mas_bottom).offset(6);
    }];
    
    self.selectIMGV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.selectIMGV];
    [self.selectIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
        make.width.height.mas_equalTo(18);
        
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
- (void)setModel:(BankModel *)model{
    _model = model;
    self.bankName.text = [NSString stringWithFormat:@"%@ %@ %@",model.collectBankName, model.collectBankBranchName, model.collectName];
    if ([model.collectBankName containsString:@"渤海"]) {
          self.bankImgView.image = [UIImage imageNamed:@"渤海银行"];
    }
    if ([model.collectBankName containsString:@"广发"]) {
        self.bankImgView.image = [UIImage imageNamed:@"广发银行"];
    }
    if ([model.collectBankName containsString:@"恒丰"]) {
        self.bankImgView.image = [UIImage imageNamed:@"恒丰银行"];
    }
    if ([model.collectBankName containsString:@"浦东"]) {
        self.bankImgView.image = [UIImage imageNamed:@"上海浦东发展银行"];
    }
    if ([model.collectBankName containsString:@"工商"]) {
        self.bankImgView.image = [UIImage imageNamed:@"上海工商银行"];
    }
    if ([model.collectBankName containsString:@"光大"]) {
        self.bankImgView.image = [UIImage imageNamed:@"中国光大银行"];
    }
    if ([model.collectBankName containsString:@"建设"]) {
        self.bankImgView.image = [UIImage imageNamed:@"中国建设银行"];
    }
    if ([model.collectBankName containsString:@"交通"]) {
        self.bankImgView.image = [UIImage imageNamed:@"中国交通银行"];
    }
    if ([model.collectBankName containsString:@"民生"]) {
        self.bankImgView.image = [UIImage imageNamed:@"中国民生银行"];
    }
    if ([model.collectBankName containsString:@"农业"]) {
        self.bankImgView.image = [UIImage imageNamed:@"中国农业银行"];
    }
    if ([model.collectBankName containsString:@"中国银行"]) {
        self.bankImgView.image = [UIImage imageNamed:@"中国银行"];
    }
    if ([model.collectBankName containsString:@"中信"]) {
        self.bankImgView.image = [UIImage imageNamed:@"中信银行"];
    }
    if ([model.collectBankName containsString:@"邮政储蓄"]) {
        self.bankImgView.image = [UIImage imageNamed:@"中国邮政储蓄银行"];
    }
    self.bankCardNo.text = model.collectBankNo;
}
@end
