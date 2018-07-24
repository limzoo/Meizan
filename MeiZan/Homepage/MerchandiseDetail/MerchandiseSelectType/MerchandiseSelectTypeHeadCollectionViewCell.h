//
//  MerchandiseSelectTypeHeadCollectionViewCell.h
//  JingXuan
//
//  Created by sfs on 2017/12/13.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface MerchandiseSelectTypeHeadCollectionViewCell : BaseCollectionViewCell
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *priceText;//imgUrl  priceText;
@property (nonatomic, strong) UILabel *selectType;
@end
