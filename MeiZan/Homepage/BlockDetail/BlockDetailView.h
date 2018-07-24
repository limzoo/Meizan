//
//  BlockDetailView.h
//  MeiZan
//
//  Created by 林宇 on 2018/2/9.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "BaseSearchBar.h"
#import "MerchandiseCollectionViewCell.h"
#import "SearchResultViewController.h"
@interface BlockDetailView : BaseView
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIView *substitutionView;
@property (nonatomic, strong) BaseSearchBar *searchBar;
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@end
