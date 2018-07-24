//
//  MerchandiseDetailCollectionReusableView.m
//  JingXuan
//
//  Created by sfs on 2017/12/13.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MerchandiseDetailCollectionReusableView.h"

@implementation MerchandiseDetailCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview{
    self.titleLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:nil];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
    }];
}
@end
