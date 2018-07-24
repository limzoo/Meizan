//
//  HeadCollectionReusableView.m
//  JingXuan
//
//  Created by sfs on 2017/12/7.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "HeadCollectionReusableView.h"
@interface HeadCollectionReusableView()

@end
@implementation HeadCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *titleHeadView = [[UIView alloc] init];
        titleHeadView.backgroundColor = STYLECOLOR;
        [self addSubview:titleHeadView];
        [titleHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.width.mas_equalTo(4);
            make.height.mas_equalTo(16);
            make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        }];
        
        self.headTitleLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:18] color:TITLECOLOR text:nil];
        [self addSubview: self.headTitleLabel];
        [self.headTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.leading.mas_equalTo(titleHeadView.mas_trailing).offset(CUSTOM_WIDTH(10));
        }];
        
        self.arrowImg = [[UIImageView alloc] init];
        self.arrowImg.image = [UIImage imageNamed:@"rightArrow"];
        [self addSubview:self.arrowImg];
        [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(8);
            make.height.mas_equalTo(13);
            make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
            make.centerY.mas_equalTo(self);
        }];
        
        self.moreLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x999999) text:@"更多"];
        [self addSubview: self.moreLabel];
        [ self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.trailing.mas_equalTo(self.arrowImg.mas_leading).offset(-CUSTOM_WIDTH(10));
        }];
    }
    return self;
}

@end
