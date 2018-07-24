//
//  HompageView.h
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "LYSlideSelectBar.h"
#import "MerchandiseModel.h"
#import "BaseSearchBar.h"
@interface HompageView : BaseView
@property (nonatomic, strong) BaseSearchBar *searchBar;
@property (nonatomic, strong) LYSlideSelectBar *slideBar;
@property (nonatomic, strong) UIView *substitutionView;
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSArray<MerchandiseModel *> *merchandiseArray;
@property (nonatomic, strong) NSDictionary *listMerchandiseDict;
@property (nonatomic, strong) NSArray *scrollingTitlesArray;
@property (nonatomic, strong) NSArray *ADArray;
@property (nonatomic, strong) UIView *masksView;
@property (nonatomic, strong) NSArray *rankArray;
@end
