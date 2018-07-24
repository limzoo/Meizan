//
//  ShopCartMerchandiseCollectionViewCell.h
//  JingXuan
//
//  Created by sfs on 2017/12/8.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "ShopCartModel.h"
@interface ShopCartMerchandiseCollectionViewCell : BaseCollectionViewCell
@property (nonatomic, strong) ShopCartModel *model;
@property (nonatomic, strong) UIButton *selectedButton;
@end
