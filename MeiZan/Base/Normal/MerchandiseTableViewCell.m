//
//  MerchandiseTableViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/14.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MerchandiseTableViewCell.h"
@interface MerchandiseTableViewCell()
@property (nonatomic, strong) UIImageView *merchandiseIconIMGV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numLabel;
@end
@implementation MerchandiseTableViewCell
- (void)createSubview{
    self.merchandiseIconIMGV = [[UIImageView alloc] init];
    self.merchandiseIconIMGV.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.merchandiseIconIMGV];
    [self.merchandiseIconIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.contentView).offset(15);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    self.numLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@"x 1"];
    self.numLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.contentView).offset(19);
    }];
    
    self.nameLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"商品名称商品名称"];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.merchandiseIconIMGV.mas_trailing).offset(10);
        make.top.mas_equalTo(self.merchandiseIconIMGV.mas_top);
        make.trailing.mas_equalTo(self.numLabel.mas_leading).offset(-CUSTOM_WIDTH(14));
    }];
    
    self.priceLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"¥ 1029"];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.merchandiseIconIMGV.mas_trailing).offset(10);
        make.bottom.mas_equalTo(self.merchandiseIconIMGV);
    }];
    
    self.detailLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@"嫩肤清莹露洗面奶"];
    self.detailLabel.numberOfLines = 0;
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.merchandiseIconIMGV.mas_trailing).offset(10);
        make.trailing.mas_equalTo(self.numLabel.mas_leading).offset(-CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(8);
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
