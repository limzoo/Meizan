//
//  FullImageCollectionViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/2/6.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "FullImageCollectionViewCell.h"
@interface FullImageCollectionViewCell()
@property (nonatomic, strong) UIImageView *mainIMGV;
@end
@implementation FullImageCollectionViewCell
- (void)createSubview{
    self.mainIMGV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.mainIMGV];
    [self.mainIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.bottom.mas_equalTo(self.contentView);
    }];
}

- (void)setPhotoUrl:(NSString *)photoUrl{
    _photoUrl = photoUrl;
    [self.mainIMGV sd_setImageWithURL:[NSURL URLWithString:photoUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            NSLog(@"%@",error);
        }
    }];
}
@end
