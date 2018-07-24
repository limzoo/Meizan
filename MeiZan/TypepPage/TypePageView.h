//
//  TypePageView.h
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseView.h"

@interface TypePageView : BaseView
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UITableView *titleTableView;
@property (nonatomic, strong) UICollectionView *merchandiseCollectonView;
@property (nonatomic, strong) NSIndexPath *tableViewCurrentSelectedIndexPath;
@property (nonatomic, strong) NSIndexPath *tableViewLastSelectedIndexPath;
@property (nonatomic, strong) NSMutableArray *typeTitleArray;
@property (nonatomic, strong) NSMutableArray *merchandiseArray;
@end
