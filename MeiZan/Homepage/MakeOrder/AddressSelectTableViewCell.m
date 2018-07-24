//
//  AddressSelectTableViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/14.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "AddressSelectTableViewCell.h"
@interface AddressSelectTableViewCell()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@property (nonatomic, strong) UIView *hasNoDefaultAddressView;
@end
@implementation AddressSelectTableViewCell
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"addressLine"];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(7);
    }];
    
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(imageView.mas_bottom).offset(3);
    }];
    
    UIButton *arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [arrowButton setImage:[UIImage imageNamed:@"rightArrow"] forState:UIControlStateNormal];
    [mainView addSubview:arrowButton];
    [arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(36);
        make.top.bottom.trailing.mas_equalTo(mainView);
    }];
    
    
    self.nameLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x000000) text:@"namenamename"];
    [mainView addSubview:self.nameLabel];
    [self.nameLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(mainView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(mainView).offset(15);
    }];
    
    self.phoneLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:COLOR_RGB16(0x000000) text:@"1234567890"];
    [mainView addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLabel.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(self.nameLabel);
    }];
    
    [self.phoneLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.nameLabel setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    
    self.stateLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:STYLECOLOR text:@"默认"];
     self.stateLabel.textAlignment = NSTextAlignmentCenter;
    self.stateLabel.layer.borderColor = STYLECOLOR.CGColor;
    self.stateLabel.layer.borderWidth = 1;
    [mainView addSubview:self.stateLabel];
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(36));
        make.height.mas_equalTo(22);
        make.centerY.mas_equalTo(self.phoneLabel);
        make.leading.mas_equalTo(self.phoneLabel.mas_trailing).offset(CUSTOM_WIDTH(10));
    }];
    
    self.addressLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@"广东省深圳市宝安区宝民一路宝通大厦804"];
    [mainView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(arrowButton.mas_leading).offset(-CUSTOM_WIDTH(14));
    }];
    
    self.hasNoDefaultAddressView = [[UIView alloc] init];
    self.hasNoDefaultAddressView.backgroundColor = [UIColor whiteColor];
    [mainView addSubview:self.hasNoDefaultAddressView];
    [self.hasNoDefaultAddressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.trailing.mas_equalTo(mainView);
    }];
    
    UILabel *announceLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x000000) text:@"+ 添加新地址"];
    announceLabel.textAlignment = NSTextAlignmentCenter;
    [self.hasNoDefaultAddressView addSubview:announceLabel];
    [announceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.leading.top.bottom.trailing.mas_equalTo(self.hasNoDefaultAddressView);
    }];
}

- (void)setModel:(UserAddressModel *)model{
    _model = model;
    /*@property (nonatomic, strong) UILabel *nameLabel;
     @property (nonatomic, strong) UILabel *stateLabel;
     @property (nonatomic, strong) UILabel *phoneLabel;
     @property (nonatomic, strong) UILabel *addressLabel;*/
    self.nameLabel.text = model.consignee;
    self.phoneLabel.text = model.mobileNo;
    self.addressLabel.text = [[[model.province stringByAppendingString:model.city] stringByAppendingString:model.district] stringByAppendingString:model.address];
    self.hasNoDefaultAddressView.hidden = YES;
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
