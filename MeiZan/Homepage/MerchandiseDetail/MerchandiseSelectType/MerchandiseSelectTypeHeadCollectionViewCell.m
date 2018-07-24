//
//  MerchandiseSelectTypeHeadCollectionViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/13.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MerchandiseSelectTypeHeadCollectionViewCell.h"
@interface MerchandiseSelectTypeHeadCollectionViewCell()
@property (nonatomic, strong) UIImageView *merchandiseIconIMGV;
@property (nonatomic, strong) UILabel *priceLabel;
@end
@implementation MerchandiseSelectTypeHeadCollectionViewCell
- (void)createSubview{
    self.merchandiseIconIMGV = [[UIImageView alloc] init];
    self.merchandiseIconIMGV .backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.merchandiseIconIMGV ];
    [self.merchandiseIconIMGV  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(14);
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(76);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
    }];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton addTarget:self action:@selector(removePage:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [self.contentView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(36);
        make.top.mas_equalTo(self.contentView).offset(8);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(8));
    }];
    
    self.selectType = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"请选择规格属性"];
    [self.contentView addSubview:self.selectType];
    [self.selectType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.merchandiseIconIMGV);
        make.leading.mas_equalTo(self.merchandiseIconIMGV.mas_trailing).offset(CUSTOM_WIDTH(10));
    }];
    
    self.priceLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:STYLECOLOR text:@"价格: ¥69"];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.selectType);
        make.bottom.mas_equalTo(self.selectType.mas_top).offset(-10);
    }];
}
- (void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    [_merchandiseIconIMGV sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:nil];
}

- (void)setPriceText:(NSString *)priceText{
    _priceText = priceText;
    _priceLabel.text = priceText;
}
- (void)removePage:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"removeSelectPage" object:nil];
}
@end
