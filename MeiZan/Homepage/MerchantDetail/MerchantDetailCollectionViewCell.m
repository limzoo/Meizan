//
//  MerchantDetailCollectionViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/12.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MerchantDetailCollectionViewCell.h"
@interface MerchantDetailCollectionViewCell()
@property (nonatomic, strong) UIImageView *merchantIconIMGV;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@end
@implementation MerchantDetailCollectionViewCell
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    self.merchantIconIMGV = [[UIImageView alloc] init];
    self.merchantIconIMGV.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.merchantIconIMGV];
    [self.merchantIconIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.merchantIconIMGV.mas_width).multipliedBy(200/375.0);
    }];
    
    UIButton *focusButton = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:1.0f fontSize:14 title:@"关注+"];
    focusButton.layer.borderColor = TEXTCOLOR.CGColor;
    focusButton.layer.borderWidth = 1;
    [self.contentView addSubview:focusButton];
    [focusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(60));
        make.height.mas_equalTo(32);
        make.top.mas_equalTo(self.merchantIconIMGV.mas_bottom).offset(14);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
    }];
    
    
    self.stateLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:STYLECOLOR text:@"已关注"];
    self.stateLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.stateLabel];
    self.stateLabel.layer.borderWidth = 1;
    self.stateLabel.layer.borderColor = STYLECOLOR.CGColor;
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.trailing.mas_equalTo(focusButton);
        make.top.mas_equalTo(focusButton.mas_bottom).offset(8);
    }];
    
    self.nameLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Medium" size:16] color:TITLECOLOR text:@"商店名称"];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.merchantIconIMGV.mas_bottom).offset(14);
        make.trailing.mas_equalTo(focusButton.mas_leading).offset(-CUSTOM_WIDTH(14));
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.height.mas_equalTo(16);
    }];
    
    UIView *insetView = [[UIView alloc] init];
    insetView.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:insetView];
    [insetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(8);
    }];
    
    self.detailLabel =  [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"精选选了MUJI制造商和生产原料，用几乎零利润的价格，剔除品牌溢价，让用户享受原品牌的品质生活。精选选了MUJI制造商和生产原料，用几乎零利润的价格，剔除品牌溢价，让用户享受原品牌的品质生活。"];
    self.detailLabel.numberOfLines = 0;
    [self.contentView addSubview:self.detailLabel];
     [self.detailLabel sizeToFit];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(4);
        make.trailing.mas_lessThanOrEqualTo(focusButton.mas_leading).offset(-CUSTOM_WIDTH(14));
        make.bottom.mas_lessThanOrEqualTo(insetView).offset(-14);
    }];
    
    
}
@end
