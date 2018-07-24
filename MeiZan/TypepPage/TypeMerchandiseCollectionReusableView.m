//
//  TypeMerchandiseCollectionReusableView.m
//  JingXuan
//
//  Created by sfs on 2017/12/7.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "TypeMerchandiseCollectionReusableView.h"
@interface TypeMerchandiseCollectionReusableView()
@property (nonatomic,strong) SDCycleScrollView *cycleView;
@end
@implementation TypeMerchandiseCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero imageURLStringsGroup:nil];
        self.cycleView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.cycleView];
        [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
            make.top.mas_equalTo(self).offset(14);
            make.centerX.centerY.mas_equalTo(self);
        }];
    }
    return self;
}
@end
