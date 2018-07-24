//
//  ItemCollectionViewCell.h
//  JingXuan
//
//  Created by sfs on 2017/12/11.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "ItemCollectionView.h"
@interface ItemCollectionViewCell : BaseCollectionViewCell
@property (nonatomic, assign) ItemCollectionViewItemType type;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *borderColor;
@end
