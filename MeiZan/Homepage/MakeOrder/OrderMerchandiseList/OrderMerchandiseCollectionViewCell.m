//
//  OrderMerchandiseCollectionViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/29.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "OrderMerchandiseCollectionViewCell.h"

@interface OrderMerchandiseCollectionViewCell()
@property (nonatomic, strong) UIImageView *merchandiseImgV;
@property (nonatomic, strong) UILabel *merchandiseName;
@property (nonatomic, strong) UILabel *merchandiseDetail;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *buyNum;
@end
@implementation OrderMerchandiseCollectionViewCell
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
        make.leading.mas_equalTo(self.merchandiseImgV.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self).offset(16);
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
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
    
    self.buyNum = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@""];
    self.buyNum.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.buyNum];
    [self.buyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(self.price);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.bottom.trailing.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (void)setModel:(PreOrderMerchandise *)model{
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
                self.price.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.COUNTY_AGENT_PRICE.floatValue/1.0,model.POINT.integerValue];
            }
            break;
        }
        case 3:{
            if (model.PRICE.floatValue != 0) {
                self.price.text = [NSString stringWithFormat:@"¥ %.2f",model.MAIN_AGENT_PRICE.floatValue/1.0];
            }else{
                self.price.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.MAIN_AGENT_PRICE.floatValue/1.0,model.POINT.integerValue];
            }
            break;
        }
        case 4:{
            if (model.PRICE.floatValue != 0) {
                self.price.text = [NSString stringWithFormat:@"¥ %.2f",model.COUNTY_AGENT_PRICE.floatValue/1.0];
            }else{
                self.price.text = [NSString stringWithFormat:@"¥ %.2f + %ld积分",model.COUNTY_AGENT_PRICE.floatValue/1.0,model.POINT.integerValue];
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
    _buyNum.text = [NSString stringWithFormat:@"X %ld",model.NUMBER.integerValue];
}
@end
