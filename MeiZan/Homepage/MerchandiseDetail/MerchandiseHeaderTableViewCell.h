//
//  MerchandiseHeaderTableViewCell.h
//  JingXuan
//
//  Created by sfs on 2017/12/11.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MerchandiseDetailModel.h"
@interface MerchandiseHeaderTableViewCell : BaseTableViewCell
@property (nonatomic, strong) MerchandiseDetailModel *model;
@property (nonatomic, strong) NSArray *goodsImageArray;
@property (nonatomic, strong) UIButton *lookButton;
@end
