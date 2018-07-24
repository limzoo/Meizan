//
//  ImageSelectTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/2.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ImageSelectTableViewCell.h"
@interface ImageSelectTableViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@end
@implementation ImageSelectTableViewCell
- (void)createSubview{
    UIImageView *imgView_1  = [[UIImageView alloc] init];
    [self.contentView addSubview:imgView_1];
    imgView_1.contentMode = UIViewContentModeScaleAspectFill;
    imgView_1.layer.masksToBounds = YES;
    imgView_1.tag = 1;
    [imgView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
    }];
    
    UIImageView *imgView_2  = [[UIImageView alloc] init];
    [self.contentView addSubview:imgView_2];
    imgView_2.contentMode = UIViewContentModeScaleAspectFill;
    imgView_2.layer.masksToBounds = YES;
    imgView_2.tag = 2;
    [imgView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(imgView_1.mas_trailing).offset(CUSTOM_WIDTH(14));
    }];
    
    UIImageView *imgView_3  = [[UIImageView alloc] init];
    imgView_3.contentMode = UIViewContentModeScaleAspectFill;
    imgView_3.layer.masksToBounds = YES;
    [self.contentView addSubview:imgView_3];
    imgView_3.tag = 3;
    [imgView_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(imgView_2.mas_trailing).offset(CUSTOM_WIDTH(14));
    }];
    
    UIImageView *imgView_4  = [[UIImageView alloc] init];
    [self.contentView addSubview:imgView_4];
    imgView_4.contentMode = UIViewContentModeScaleAspectFill;
    imgView_4.layer.masksToBounds = YES;
    imgView_4.tag = 1;
    [imgView_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.centerY.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(imgView_3.mas_trailing).offset(CUSTOM_WIDTH(14));
    }];
    UIImageView *const_img = [[UIImageView alloc] init];
    const_img.image = [UIImage imageNamed:@"rightArrow"];
    [self.contentView addSubview:const_img];
    [const_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(8);
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
    }];
    
    self.titleLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x999999) text:@""];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(const_img.mas_leading).offset(-CUSTOM_WIDTH(10));
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
- (void)setImgUrlArray:(NSArray *)imgUrlArray{
    _imgUrlArray = imgUrlArray;
    NSUInteger imgViewNum = imgUrlArray.count > 4 ? 4 : imgUrlArray.count;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < imgViewNum; i ++) {
            UIImageView *imgView = [self viewWithTag:i + 1];
            [imgView sd_setImageWithURL:imgUrlArray[i]];
        };
        weakSelf.titleLabel.text = [NSString stringWithFormat:@"共%ld类",imgUrlArray.count];

    });
}
@end
