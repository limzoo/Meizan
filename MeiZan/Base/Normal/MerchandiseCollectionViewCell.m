//
//  MerchandiseCollectionViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MerchandiseCollectionViewCell.h"
@interface MerchandiseCollectionViewCell()
@property (nonatomic, strong) UILabel *merchandiseTitleLabel;
@property (nonatomic, strong) UILabel *merchandiseDetailLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *merchandiseImgView;
//@property (nonatomic, strong) UILabel *leftTopCornerStateLabel;
@property (nonatomic, strong) UILabel *soldNumLabel;
@end
@implementation MerchandiseCollectionViewCell
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    self.merchandiseImgView = [[UIImageView alloc] init];
//    self.merchandiseImgView.image;
    self.merchandiseImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.merchandiseImgView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.merchandiseImgView];
    [self.merchandiseImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self).offset(5);
        make.trailing.mas_equalTo(self).offset(-5);
        make.centerX.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.merchandiseImgView.mas_width).multipliedBy(120/178.0);
    }];
    
//    self.leftTopCornerStateLabel = [UILabel initWithSystemFontOfSize:12 color:COLOR_RGB16(0xffffff) text:@"上新"];
//    self.leftTopCornerStateLabel.backgroundColor = BACKGROUNDREDCOLOR;
//    [self.contentView addSubview:self.leftTopCornerStateLabel];
//    [self.leftTopCornerStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.leading.mas_equalTo(self.contentView);
//        make.height.mas_equalTo(16);
//        make.width.mas_equalTo(CUSTOM_WIDTH(38));
//    }];
//
    self.merchandiseTitleLabel = [UILabel initWithSystemFontOfSize:14 color:TITLECOLOR text:@"标题"];
    self.merchandiseTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.merchandiseTitleLabel];
    [self.merchandiseTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(5));
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(5));
        make.top.mas_equalTo(self.merchandiseImgView.mas_bottom).offset(14);
    }];
    
    self.merchandiseDetailLabel = [UILabel initWithSystemFontOfSize:12 color:COLOR_RGB16(0x999999) text:@"细节"];
    [self.contentView addSubview:self.merchandiseDetailLabel];
    [self.merchandiseDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.merchandiseTitleLabel);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(5));
        make.top.mas_equalTo(self.merchandiseTitleLabel.mas_bottom).offset(6);
    }];
    
    
    self.priceLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:STYLECOLOR text:@"￥213.00"];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.merchandiseTitleLabel);
        make.top.mas_equalTo(self.merchandiseDetailLabel.mas_bottom).offset(11);
    }];
    
    self.soldNumLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@"2098付款"];
    [self.contentView addSubview:self.soldNumLabel];
    [self.soldNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.priceLabel.mas_centerY);
        make.leading.mas_equalTo(self.priceLabel.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_greaterThanOrEqualTo(self.contentView).mas_offset(CUSTOM_WIDTH(14));
    }];
    [self.priceLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.soldNumLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setModel:(MerchandiseModel *)model{
    _model = model;
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    //用户类型(1.商户;2个人;3总代理商;4县代理商)
    switch (config.userInfo.userType.intValue) {
        case 1:{
            if (model.PRICE.floatValue != 0) {
                _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",model.PRICE.floatValue/1.0];
            }else{
                _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.PRICE.floatValue/1.0,model.POINT.integerValue];
            }
             _soldNumLabel.text = [NSString stringWithFormat:@"%ld人付款",model.BUY_COUNT.integerValue];
            break;
        }
        case 2:{
            if (model.PRICE.floatValue != 0) {
                _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",model.PRICE.floatValue/1.0];
            }else{
                _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.PRICE.floatValue/1.0,model.POINT.integerValue];
            }
             _soldNumLabel.text = [NSString stringWithFormat:@"%ld人付款",model.BUY_COUNT.integerValue];
            break;
        }
        case 3:{
            if (model.PRICE.floatValue != 0) {
                _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",model.MAIN_AGENT_PRICE.floatValue/1.0];
            }else{
                _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.MAIN_AGENT_PRICE.floatValue/1.0,model.POINT.integerValue];
            }
            
             _soldNumLabel.text = [NSString stringWithFormat:@"%ld人付款",model.BUY_COUNT.integerValue];
            break;
        }
        case 4:{
            if (model.PRICE.floatValue != 0) {
                _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",model.COUNTY_AGENT_PRICE.floatValue/1.0];
            }else{
                _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.COUNTY_AGENT_PRICE.floatValue/1.0,model.POINT.integerValue];
            }
             _soldNumLabel.text = [NSString stringWithFormat:@"%ld人付款",model.BUY_COUNT.integerValue];
            break;
        }
        default:
             _priceLabel.text = @"";
             _soldNumLabel.text = @"";
            break;
    }
    _merchandiseTitleLabel.text = model.GOODS_NAME;
    _merchandiseDetailLabel.text = model.GOODS_TITLE;
    [_merchandiseImgView sd_setImageWithURL:[NSURL URLWithString:model.SHOW_IMAGE_URL] placeholderImage:[UIImage imageNamed:@"merchandisePlaceholder"]];
}
@end
