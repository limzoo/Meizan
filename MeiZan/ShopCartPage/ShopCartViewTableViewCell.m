//
//  ShopCartViewTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/16.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ShopCartViewTableViewCell.h"

@interface ShopCartViewTableViewCell()

@property (nonatomic, strong) UILabel *titleLabel;
@property  (nonatomic, strong) UILabel *detailLabel;
@property  (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *merchandiseImageView;

@end
@implementation ShopCartViewTableViewCell
- (void)setModel:(ShopCartModel *)model{
    _model = model;
    self.titleLabel.text = model.GOODS_NAME;
    self.detailLabel.text = model.specsInfo;
    [self.selectTypeButton setTitle:model.specsInfo forState:UIControlStateNormal];
    [self.merchandiseImageView sd_setImageWithURL:[NSURL URLWithString:model.SHOW_IMAGE_URL]];
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    switch (config.userInfo.userType.intValue) {
        case 1:{
            if (model.PRICE.floatValue != 0) {
                self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",model.PRICE.floatValue/1.0];
            }else{
                self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.COUNTY_AGENT_PRICE.floatValue/1.0,model.POINT.longValue];
            }
            break;
        }
        case 2:{
            if (model.PRICE.floatValue != 0) {
                self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",model.PRICE.floatValue/1.0];
            }else{
                self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.COUNTY_AGENT_PRICE.floatValue/1.0,model.POINT.longValue];
            }
            break;
        }
        case 3:{
            if (model.PRICE.floatValue != 0) {
                self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",model.MAIN_AGENT_PRICE.floatValue/1.0];
            }else{
                self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.MAIN_AGENT_PRICE.floatValue/1.0,model.POINT.longValue];
            }
            break;
        }
        case 4:{
            if (model.PRICE.floatValue != 0) {
                self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",model.COUNTY_AGENT_PRICE.floatValue/1.0];
            }else{
                self.priceLabel.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.COUNTY_AGENT_PRICE.floatValue/1.0,model.POINT.longValue];
            }
            break;
        }
        default:
            break;
    }
    self.numLabel.text = [NSString stringWithFormat:@"X %ld",model.NUMBER.longValue];
    
    self.selectNumView.numTextField.text = [NSString stringWithFormat:@"%ld",model.NUMBER.longValue];
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
    self.merchandiseImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.merchandiseImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.merchandiseImageView];
    [self.merchandiseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.selectedButton.mas_trailing);
    }];
    
    self.editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.editButton];
    [self.editButton setImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(32);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(3));
        make.top.mas_equalTo(self.contentView).offset(3);
    }];
    
    self.titleLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:nil];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(CUSTOM_WIDTH(18));
        make.leading.mas_equalTo(self.merchandiseImageView.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.trailing.mas_equalTo(self.editButton.mas_leading).offset(-CUSTOM_WIDTH(14));
    }];
    
    self.detailLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@"BLABALBALANALAABAN"];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(CUSTOM_WIDTH(8));
        make.leading.mas_equalTo(self.titleLabel);
        make.trailing.mas_equalTo(self.titleLabel);
    }];
    
    
    self.priceLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:STYLECOLOR text:nil];
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
        make.width.mas_equalTo(126);
    }];
    
    self.selectNumView = [[SelectNumView alloc] init];
    self.selectNumView.alpha = 0;
    [self.contentView addSubview:self.selectNumView];
    [self.selectNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.bottom.mas_equalTo(self.numLabel);
        make.leading.mas_equalTo(self.priceLabel);
    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.bottom.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    self.selectTypeButton = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:2 fontSize:14 title:@""];
    self.selectTypeButton.alpha = 0;
    self.selectTypeButton.layer.borderWidth = 0.5;
    self.selectTypeButton.layer.borderColor = TEXTCOLOR.CGColor;
    [self.contentView addSubview:self.selectTypeButton];
    [self.selectTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(self.numLabel);
        make.leading.mas_equalTo(self.priceLabel);
        make.top.mas_equalTo(self.titleLabel);
    }];
}

- (void)setIsEdit:(BOOL)isEdit{
    _isEdit = isEdit;
    [UIView animateWithDuration:0.4 animations:^{
        if (isEdit) {
            self.selectNumView.alpha = 1;
            self.numLabel.alpha = 0;
            self.titleLabel.alpha = 0;
            self.detailLabel.alpha = 0;
            self.priceLabel.alpha = 0;
            self.selectTypeButton.alpha = 1;
        }else{
            self.selectNumView.alpha = 0;
            self.numLabel.alpha = 1;
            self.titleLabel.alpha = 1;
            self.detailLabel.alpha = 1;
            self.priceLabel.alpha = 1;
            self.selectTypeButton.alpha = 0;
        }
    }];
}
@end
