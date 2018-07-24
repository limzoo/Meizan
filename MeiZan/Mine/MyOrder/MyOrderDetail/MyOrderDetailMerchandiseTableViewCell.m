//
//  MyOrderDetailMerchandiseTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/24.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyOrderDetailMerchandiseTableViewCell.h"
@interface MyOrderDetailMerchandiseTableViewCell()
@property (nonatomic, strong) UIImageView *merchandiseIMGV;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *detail;
//@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UILabel *fullPrice;
@property (nonatomic, strong) UILabel *num;
@end
@implementation MyOrderDetailMerchandiseTableViewCell
- (void)createSubview{
    self.merchandiseIMGV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.merchandiseIMGV];
    self.merchandiseIMGV.contentMode = UIViewContentModeScaleAspectFill;
    self.merchandiseIMGV.layer.masksToBounds = YES;
    [self.merchandiseIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(80);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.contentView).offset(16);
    }];
    
    self.num = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x999999) text:nil];
    [self.contentView addSubview:self.num];
    
    self.name = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:nil];
    self.name.numberOfLines = 0;
    [self.contentView addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.merchandiseIMGV.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.top.mas_equalTo(self.contentView).offset(19);
        make.trailing.mas_equalTo(self.num.mas_leading).offset(-5);
    }];
    
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.name);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
    }];
    
    self.detail = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:nil];
    [self.contentView addSubview:self.detail];
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.name);
        make.top.mas_equalTo(self.name.mas_bottom).offset(8);
    }];
    
//    self.price = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:nil];
//    [self.contentView addSubview:self.price];
//    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(self.name);
//        make.bottom.mas_equalTo(self.merchandiseIMGV);
//    }];
    
//    self.fullPrice = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:nil];
//    [self.contentView addSubview:self.fullPrice];
//    [self.fullPrice mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(self.price);
//        make.leading.mas_equalTo(self.price.mas_trailing).offset(10);
//    }];
    
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(8);
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

- (void)setModel:(OrderMerchandiseModel *)model{
    _model = model;
    /*@property (nonatomic, strong) UIImageView *merchandiseIMGV;
     @property (nonatomic, strong) UILabel *name;
     @property (nonatomic, strong) UILabel *detail;
     @property (nonatomic, strong) UILabel *price;
     @property (nonatomic, strong) UILabel *fullPrice;
     @property (nonatomic, strong) UILabel *num;*/
    [self.merchandiseIMGV sd_setImageWithURL:[NSURL URLWithString: model.showImageUrl] placeholderImage:nil];
    self.name.text = model.goodsName;
    self.detail.text = model.specsInfo;
//    self.price.text = [NSString stringWithFormat:@"¥ %.2f", model.price.floatValue];
    self.fullPrice.text = nil;
    self.num.text = [NSString stringWithFormat:@"X%ld", model.number.integerValue];
}
@end
