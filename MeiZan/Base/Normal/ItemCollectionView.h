//
//  ItemCollectionView.h
//  JingXuan
//
//  Created by sfs on 2017/12/11.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ItemCollectionViewItemType){
    ItemCollectionViewItemTypeBorder = 0,
    ItemCollectionViewItemTypePoint = 1
};
@interface ItemCollectionView : UICollectionView
@property (nonatomic, strong) NSArray<NSString *> *titlesArray;
@property (nonatomic, assign) ItemCollectionViewItemType type;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *borderColor;
@end
