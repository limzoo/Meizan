//
//  UserReplyTableViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/11.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "UserReplyTableViewCell.h"
#import "RatingBar.h"
@interface UserReplyTableViewCell()
@property (nonatomic, strong) UIImageView *userIconIMGV;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) RatingBar *rateBar;
@property (nonatomic, strong) UILabel *replyDetailLabel;
@property (nonatomic, strong) UILabel *replyLabel;
@end
@implementation UserReplyTableViewCell
- (void)createSubview{

    
    self.userIconIMGV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.userIconIMGV];
    [self.userIconIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.width.mas_equalTo(CUSTOM_WIDTH(30));
        make.height.mas_equalTo(self.userIconIMGV.mas_width);
    }];
    
    self.userNameLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"用户名用户名"];
    [self.contentView addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.userIconIMGV);
        make.leading.mas_equalTo(self.userIconIMGV.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.width.mas_lessThanOrEqualTo(200);
    }];
    
    self.rateBar = [[RatingBar alloc] initWithFrame:CGRectMake(0, 0, 98, 13) unselected_imageName:@"star_gray" selected_imageName:@"star_yellow"];
    self.rateBar.enable = NO;
    [self.contentView addSubview:self.rateBar];
    [self.rateBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.userNameLabel.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.centerY.mas_equalTo(self.userNameLabel);
        make.width.mas_equalTo(98);
        make.height.mas_equalTo(13);
    }];
    
    self.replyDetailLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x999999) text:@"xxxx.xx.xx  xx:xx xx"];
    [self.contentView addSubview:self.replyDetailLabel];
    [self.replyDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.userIconIMGV.mas_bottom).offset(10);
    }];
    
    self.replyLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@".PingFangSC-Regular" size:14] color:TITLECOLOR text:@"夭修，超级好用捏，炒鸡推荐的诶～不买就是你会很亏的捏"];
    self.replyLabel.numberOfLines = 0;
    [self.contentView addSubview:self.replyLabel];
    [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.replyDetailLabel.mas_bottom).offset(10);
    }];
    
    UIImageView *imgView_2 = [[UIImageView alloc] init];
    imgView_2.tag = 101;
    imgView_2.hidden = YES;
      [self.contentView addSubview:imgView_2];
    [imgView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.replyLabel.mas_bottom).offset(14);
    }];
    
    UIImageView *imgView_1 = [[UIImageView alloc] init];
    imgView_1.hidden = YES;
    imgView_1.tag = 100;
    [self.contentView addSubview:imgView_1];
    [imgView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.centerY.mas_equalTo(imgView_2);
        make.trailing.mas_equalTo(imgView_2.mas_leading).offset(-10);
    }];
    
    UIImageView *imgView_3 = [[UIImageView alloc] init];
    imgView_3.hidden = YES;
    imgView_3.tag = 102;
    [self.contentView addSubview:imgView_3];
    [imgView_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.centerY.mas_equalTo(imgView_2);
        make.leading.mas_equalTo(imgView_2.mas_trailing).offset(10);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = COLOR_RGB16(0xf5f5f5);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
        
    }];
}

- (void)setModel:(MerchandiseUserComment *)model{
    _model = model;
    /*@property (nonatomic, strong) UIImageView *userIconIMGV;
     @property (nonatomic, strong) UILabel *userNameLabel;
     @property (nonatomic, strong) RatingBar *rateBar;
     @property (nonatomic, strong) UILabel *replyDetailLabel;
     @property (nonatomic, strong) UILabel *replyLabel;*/
    [self.userIconIMGV sd_setImageWithURL:[NSURL URLWithString:model.PHOTO_URL] placeholderImage:[UIImage imageNamed:@"评论头像默认"]];
    self.userNameLabel.text = model.NICK_NAME;
    self.rateBar.starNumber = model.GOODS_SCORE;
    self.replyDetailLabel.text = [model.CREATE_TIME stringByAppendingString:[NSString stringWithFormat:@"  %@", model.SPECS_INFO]];
    self.replyLabel.text = model.CONTENT;
    if (model.APPRAISES_ANNEX.length > 0) {
        NSArray *tempArray = [model.APPRAISES_ANNEX componentsSeparatedByString:@","];
        int i = 100;
        for (NSString *str in tempArray) {
            UIImageView *imgV = [self viewWithTag:i];
            imgV.hidden = NO;
            [imgV sd_setImageWithURL:[NSURL URLWithString:str] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                NSLog(@"%@",error);
            }];
            i ++;
        }
    }else{
        for (int i = 100; i < 103; i ++) {
            UIImageView *imgView = [self viewWithTag:i];
            imgView.hidden = YES;
        }
    }
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
