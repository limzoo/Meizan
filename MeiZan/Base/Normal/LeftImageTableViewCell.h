//
//  LeftImageTableViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/2.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface LeftImageTableViewCell : BaseTableViewCell
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImageView *titleImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *selectImgView;
@end
