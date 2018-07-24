//
//  MyOrderDetailAddressTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/24.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyOrderDetailAddressTableViewCell.h"
@interface MyOrderDetailAddressTableViewCell()
@end
@implementation MyOrderDetailAddressTableViewCell
- (void)createSubview{
    UIView *mainView = [[UIView alloc] init];
    mainView.backgroundColor = COLOR_RGB16(0xfffced);
    [self.contentView addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self);
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
    
    self.addressLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@""];
    [mainView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(15);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
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
