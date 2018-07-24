//
//  ShopCartMerchandiseCollectionViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/8.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "ShopCartMerchandiseCollectionViewCell.h"
@interface ShopCartMerchandiseCollectionViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property  (nonatomic, strong) UILabel *detailLabel;
@property  (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *merchandiseImageView;
@property (nonatomic, strong) UILabel *numLabel;
@end
@implementation ShopCartMerchandiseCollectionViewCell
- (void)setModel:(ShopCartModel *)model{
    _model = model;
    self.titleLabel.text = model.GOODS_NAME;
    self.detailLabel.text = model.specsInfo;
    [self.merchandiseImageView sd_setImageWithURL:[NSURL URLWithString:model.SHOW_IMAGE_URL]];
    self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",model.PRICE.floatValue];
    self.numLabel.text = [NSString stringWithFormat:@"X %ld",model.NUMBER.integerValue];
    
}
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    self.selectedButton = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0xffffff) backGroudColor:COLOR_RGB16(0xffffff) cornerRadius:0 fontSize:0 title:nil];
    [self.selectedButton setImage:[UIImage imageNamed:@"nick_unselect"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.selectedButton];
    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.mas_equalTo(self.contentView);
        make.width.mas_equalTo(CUSTOM_WIDTH(46));
    }];
    
    self.merchandiseImageView = [[UIImageView alloc] init];
    self.merchandiseImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.merchandiseImageView];
    [self.merchandiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.selectedButton.mas_trailing);
    }];
    
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:editButton];
    [editButton setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(16);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.contentView).offset(19);
    }];
    
    self.titleLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:nil];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(CUSTOM_WIDTH(18));
        make.leading.mas_equalTo(self.merchandiseImageView.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.trailing.mas_equalTo(editButton.mas_leading).offset(-CUSTOM_WIDTH(14));
    }];
    
    self.detailLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@"BLABALBALANALAABAN"];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(CUSTOM_WIDTH(8));
        make.leading.mas_equalTo(self.titleLabel);
        make.trailing.mas_equalTo(self.titleLabel);
    }];
    
   
    self.priceLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:nil];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView).offset(-16);
        make.leading.mas_equalTo(self.titleLabel);
//        make.trailing.mas_greaterThanOrEqualTo(buttonView.mas_leading).offset(-CUSTOM_WIDTH(8));
    }];
    self.numLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@""];
    self.numLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
        make.bottom.mas_equalTo(self.contentView).offset(-16);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.bottom.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}
@end
