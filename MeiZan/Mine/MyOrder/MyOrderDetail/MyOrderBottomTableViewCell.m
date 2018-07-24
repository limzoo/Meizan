//
//  MyOrderBottomTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/24.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyOrderBottomTableViewCell.h"
@interface MyOrderBottomTableViewCell()

@end
@implementation MyOrderBottomTableViewCell
- (void)createSubview{
//    UILabel *const_peisongfangshi = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"配送方式"];
//    [self.contentView addSubview:const_peisongfangshi];
//    [const_peisongfangshi mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
//        make.top.mas_equalTo(self).offset(15);
//        make.height.mas_equalTo(14);
//    }];
//
//    UIView *lineView_1 = [[UIView alloc] init];
//    lineView_1.backgroundColor = INSETCOLOR;
//    [self.contentView addSubview:lineView_1];
//    [lineView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
//        make.height.mas_equalTo(1);
//        make.top.mas_equalTo(const_peisongfangshi.mas_bottom).offset(15);
//        make.trailing.mas_equalTo(self);
//    }];
//
//    UILabel *const_peisongshangmen = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"配送上门"];
//    [self.contentView addSubview:const_peisongshangmen];
//    [const_peisongshangmen mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
//        make.centerY.mas_equalTo(const_peisongfangshi);
//        make.height.mas_equalTo(14);
//    }];
//
    UIView *buttonView = [[UIView alloc] init];
    buttonView.backgroundColor = COLOR_RGB16(0xfafafa);
    [self.contentView addSubview:buttonView];
    [buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self);
    }];
    
    UILabel *const_announce = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@".PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@"如有疑问请拨打客服热线400-961-2016"];
    [self.contentView addSubview:const_announce];
    [const_announce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(buttonView).offset(10);
        make.centerX.mas_equalTo(buttonView);
    }];
    
    self.rightButton = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:4 fontSize:14 title:@""];
    self.rightButton.hidden = YES;
    self.rightButton.layer.borderWidth = 0.5;
    self.rightButton.layer.borderColor = STYLECOLOR.CGColor;
    [self.contentView addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(77);
        make.height.mas_equalTo(34);
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        make.top.mas_equalTo(const_announce.mas_bottom).offset(36);
    }];
    
    self.middleButton = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0x666666) backGroudColor:[UIColor whiteColor] cornerRadius:4 fontSize:14 title:@""];
     self.middleButton.hidden = YES;
    self.middleButton.layer.borderWidth = 0.5;
    self.middleButton.layer.borderColor = COLOR_RGB16(0x666666).CGColor;
    [self.contentView addSubview:self.middleButton];
    [self.middleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(77);
        make.height.mas_equalTo(34);
        make.trailing.mas_equalTo(self.rightButton.mas_leading).offset(-CUSTOM_WIDTH(14));
        make.top.mas_equalTo(const_announce.mas_bottom).offset(36);
    }];
    
    self.leftButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor blueColor] backGroudColor:[UIColor whiteColor] cornerRadius:4 fontSize:14 title:@""];
     self.leftButton.hidden = YES;
    self.leftButton.layer.borderWidth = 0.5;
    self.leftButton.layer.borderColor = [UIColor blueColor].CGColor;
    [self.contentView addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(77);
        make.height.mas_equalTo(34);
        make.trailing.mas_equalTo(self.middleButton.mas_leading).offset(-CUSTOM_WIDTH(14));
        make.top.mas_equalTo(const_announce.mas_bottom).offset(36);
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
