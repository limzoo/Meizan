//
//  TypeMerchandiseCollectionViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/7.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "TypeMerchandiseCollectionViewCell.h"
@interface TypeMerchandiseCollectionViewCell()
@property (nonatomic, strong) UIImageView *merchandiseImgV;
@property (nonatomic, strong) UILabel *merchandiseName;
@property (nonatomic, strong) UILabel *merchandiseDetail;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *soldNum;
@property (nonatomic, strong) UILabel *buyCount;
@end
@implementation TypeMerchandiseCollectionViewCell
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    self.merchandiseImgV = [[UIImageView alloc] init];
    self.merchandiseImgV.layer.masksToBounds = YES;
    self.merchandiseImgV.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.merchandiseImgV];
    [self.merchandiseImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(16);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.bottom.mas_equalTo(self).offset(-16);
        make.width.mas_equalTo(self.merchandiseImgV.mas_height).multipliedBy(1);
    }];
    
    self.merchandiseName = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"item"];
    self.merchandiseName.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.merchandiseName];
    [self.merchandiseName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.merchandiseImgV.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.top.mas_equalTo(self).offset(16);
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(10));
    }];
    
    self.merchandiseDetail = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@"item"];
     self.merchandiseDetail.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.merchandiseDetail];
    [self.merchandiseDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.merchandiseImgV.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.top.mas_equalTo(self.merchandiseName.mas_bottom).offset(10);
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(10));
    }];
    
    self.price = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:STYLECOLOR text:@"¥ 1234"];
    [self.contentView addSubview:self.price];
    self.price.textAlignment = NSTextAlignmentLeft;
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.merchandiseImgV.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.bottom.mas_equalTo(self.merchandiseImgV);
    }];
    
    self.buyCount = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@""];
    [self.contentView addSubview:self.buyCount];
    self.buyCount.textAlignment = NSTextAlignmentRight;
    [self.buyCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.price.mas_trailing).offset(CUSTOM_WIDTH(14));
         make.bottom.mas_equalTo(self.merchandiseImgV);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_RGB16(0xf5f5f5);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.height.mas_equalTo(1);
        make.bottom.trailing.mas_equalTo(self);
    }];
}

- (void)setModel:(MerchandiseModel *)model{
    _model = model;
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    //用户类型(1.商户;2个人;3总代理商;4县代理商)
    switch (config.userInfo.userType.intValue) {
        case 1:{
            if (model.PRICE.floatValue != 0) {
                self.price.text = [NSString stringWithFormat:@"¥ %.2f",model.PRICE.floatValue/1.0];
            }else{
                self.price.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.COUNTY_AGENT_PRICE.floatValue/1.0,model.POINT.integerValue];
            }
            break;
        }
        case 2:{
            if (model.PRICE.floatValue != 0) {
                self.price.text = [NSString stringWithFormat:@"¥ %.2f",model.PRICE.floatValue/1.0];
            }else{
                self.price.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.COUNTY_AGENT_PRICE.floatValue/1.0,model.POINT.longValue];
            }
            break;
        }
        case 3:{
            if (model.PRICE.floatValue != 0) {
                self.price.text = [NSString stringWithFormat:@"¥ %.2f",model.MAIN_AGENT_PRICE.floatValue/1.0];
            }else{
                self.price.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.MAIN_AGENT_PRICE.floatValue/1.0,model.POINT.longValue];
            }
            break;
        }
        case 4:{
            if (model.PRICE.floatValue != 0) {
                self.price.text = [NSString stringWithFormat:@"¥ %.2f",model.COUNTY_AGENT_PRICE.floatValue/1.0];
            }else{
                self.price.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.COUNTY_AGENT_PRICE.floatValue/1.0,model.POINT.longValue];
            }
            break;
        }
        default:
            _price.text = @"";
            break;
    }
    [_merchandiseImgV sd_setImageWithURL:[NSURL URLWithString: model.SHOW_IMAGE_URL]];
    _merchandiseName.text = model.GOODS_NAME;
    _merchandiseDetail.text = model.GOODS_TITLE;
    _buyCount.text = [NSString stringWithFormat:@"%ld人付款",model.BUY_COUNT.longValue];
}
@end
