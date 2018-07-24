//
//  ManageInvoiceTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/19.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ManageInvoiceTableViewCell.h"
@interface ManageInvoiceTableViewCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *defaultLabel;
@end
@implementation ManageInvoiceTableViewCell
- (void)createSubview{
    self.nameLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@""];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
    }];
    
    self.selectImg = [[UIImageView alloc] init];
    self.selectImg.image = [UIImage imageNamed:@"nick_unselect"];
    [self.contentView addSubview:self.selectImg];
    [self.selectImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(18);
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
    }];
    
    self.defaultLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:STYLECOLOR text:@"默认"];
    self.defaultLabel.textAlignment = NSTextAlignmentCenter;
    self.defaultLabel.layer.borderWidth = 0.5;
    self.defaultLabel.layer.borderColor = STYLECOLOR.CGColor;
    [self.contentView addSubview:self.defaultLabel];
    [self.defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(36));
        make.height.mas_equalTo(22);
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.nameLabel.mas_trailing).offset(CUSTOM_WIDTH(6));
    }];
}

- (void)setModel:(InvoiceModel *)model{
    _model = model;
    NSString *tempType;
    if ([model.invoiceType isEqualToString:@"1"]) {
        tempType = @"个人";
        self.nameLabel.text = tempType;
    }else{
         tempType = @"单位";
        self.nameLabel.text = [tempType stringByAppendingString:[NSString stringWithFormat:@" - %@",model.invoiceName]];
    }
    if ([model.isDefault isEqualToString:@"1"]) {
        self.defaultLabel.hidden = NO;
    }else{
        self.defaultLabel.hidden = YES;
    }
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
