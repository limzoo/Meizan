//
//  HP_blockCollectionViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/7.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "HP_blockCollectionViewCell.h"
@interface HP_blockCollectionViewCell()
@end
@implementation HP_blockCollectionViewCell
- (void)createSubview{
    NSArray *titleArray = @[@"热门产品",@"特价促销",@"新品上架",@"积分兑换"];
    for (int i = 0; i < 4; i ++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor whiteColor];
        button.tag = i + 100;
        button.frame = CGRectMake(i * self.contentView.bounds.size.width/4, 0, self.contentView.bounds.size.width/4, self.contentView.bounds.size.height);
        [self.contentView addSubview:button];
        
        UIImageView *imgView = [[UIImageView alloc] init];
//        imgView.userInteractionEnabled = YES;
        imgView.image = [UIImage imageNamed:titleArray[i]];
        [button addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(52);
            make.height.mas_equalTo(52);
            make.top.mas_equalTo(button.mas_top).offset(18);
            make.centerX.mas_equalTo(button);
        }];
        
        UILabel *title = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x666666) text:titleArray[i]];
//        title.userInteractionEnabled = YES;
        [button addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(button);
            make.top.mas_equalTo(imgView.mas_bottom).offset(14);
        }];
        
        
        [button addSubview:imgView];
    }
}
@end
