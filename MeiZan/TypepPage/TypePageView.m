//
//  TypePageView.m
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "TypePageView.h"
#import "TypeTitleTableViewCell.h"
#import "TypeMerchandiseCollectionViewCell.h"
#import "TypeMerchandiseCollectionReusableView.h"
#import "BaseSearchBar.h"
#import "TypeModel.h"
#import "TypePageViewController.h"
#import "MerchandiseViewController.h"
#import "TypePageViewController.h"
#import "SearchResultViewController.h"
@interface TypePageView()<UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@end
@implementation TypePageView
#pragma mark -<tableView>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.typeTitleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TypeTitleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TypeTitleTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = ((TypeModel *)self.typeTitleArray[indexPath.row]).categoryName;
    if (indexPath == self.tableViewCurrentSelectedIndexPath) {
        cell.didSelected = YES;
    }else{
        cell.didSelected = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath != self.tableViewCurrentSelectedIndexPath) {
        self.tableViewLastSelectedIndexPath = self.tableViewCurrentSelectedIndexPath;
        self.tableViewCurrentSelectedIndexPath = indexPath;
        [self.titleTableView reloadRowsAtIndexPaths:@[self.tableViewLastSelectedIndexPath, self.tableViewCurrentSelectedIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [((TypePageViewController *)self.myViewController) loadTypeMerchandiseWithTypeIndex:indexPath.row withPage:1];
        [self.merchandiseCollectonView reloadData];
    }
}

- (void)setMerchandiseArray:(NSMutableArray *)merchandiseArray{
    _merchandiseArray = merchandiseArray;
    [_merchandiseCollectonView reloadData];
    if (merchandiseArray.count == 0) {
        [Tool showNoDataPicOnView:self.merchandiseCollectonView withImage:[UIImage imageNamed:@"订单空"] title:@"暂无商品" size:CGSizeMake(138, 140) topDistance:150];
    }else{
        [Tool hideNoDataPicOnView:self.merchandiseCollectonView];
    }
}

#pragma mark -<collectionView>
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(self.merchandiseCollectonView.bounds.size.width, 135);
//}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//        TypeMerchandiseCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"TypeMerchandiseCollectionReusableView" forIndexPath:indexPath];
//        return view;
//    }
//    return nil;
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.merchandiseArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(294, 110);
}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(29, 20, 29, 20);
//}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 20;
//}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TypeMerchandiseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeMerchandiseCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.merchandiseArray[indexPath.row];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.merchandiseCollectonView) {
        MerchandiseModel *model = self.merchandiseArray[indexPath.row];
        MerchandiseViewController *vc = [[MerchandiseViewController alloc] initWithMerchandiseID:[NSString stringWithFormat:@"%ld",model.ID.integerValue]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.myViewController.navigationController pushViewController:vc animated:YES];
    }
}
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//    return 14;
//}

- (void)setTypeTitleArray:(NSMutableArray *)typeTitleArray{
    _typeTitleArray = typeTitleArray;
    [_titleTableView reloadData];
}

- (void)configInitial{
    self.tableViewCurrentSelectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.tableViewLastSelectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
}

- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    self.searchBar = [[BaseSearchBar alloc] init];
    self.searchBar.delegate =self;
    self.searchBar.placeholder = @"  搜索商品";
    self.searchBar.tintColor = [UIColor clearColor];
    self.searchBar.layer.borderColor = COLOR_RGB16(0xf5f5f5).CGColor;
    self.searchBar.layer.borderWidth = 1;
    
    //    self.searchBar.place
    for (UIView *subView in self.searchBar.subviews) {
        if ([subView isKindOfClass:[UIView  class]]) {
            [[subView.subviews objectAtIndex:0] removeFromSuperview];
        }
    }
    [self addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self).offset(CUSTOM_WIDTH(30));
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        make.height.mas_equalTo(38);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(self.searchBar.mas_bottom).offset(9);
        make.height.mas_equalTo(1);
    }];
    
    self.titleTableView = [[UITableView alloc] init];
    self.titleTableView.delegate = self;
    self.titleTableView.dataSource = self;
    self.titleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.titleTableView registerClass:[TypeTitleTableViewCell class] forCellReuseIdentifier:@"TypeTitleTableViewCell"];
    [self addSubview:self.titleTableView];
    [self.titleTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.mas_equalTo(self);
        make.top.mas_equalTo(lineView.mas_bottom);
        make.width.mas_equalTo(CUSTOM_WIDTH(80));
    }];
    
    UIView *lineView_2 = [[UIView alloc] init];
    lineView_2.backgroundColor = INSETCOLOR;
    [self addSubview:lineView_2];
    [lineView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.titleTableView.mas_trailing);
        make.top.mas_equalTo(lineView.mas_bottom);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(self);
    }];
    
    self.merchandiseCollectonView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.merchandiseCollectonView.backgroundColor = [UIColor whiteColor];
    self.merchandiseCollectonView.delegate = self;
    self.merchandiseCollectonView.dataSource = self;
    [self.merchandiseCollectonView registerClass:[TypeMerchandiseCollectionViewCell class] forCellWithReuseIdentifier:@"TypeMerchandiseCollectionViewCell"];
    [self.merchandiseCollectonView registerClass:[TypeMerchandiseCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TypeMerchandiseCollectionReusableView"];
    [self addSubview:self.merchandiseCollectonView];
    [self.merchandiseCollectonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(lineView_2.mas_trailing);
        make.top.mas_equalTo(lineView.mas_bottom);
        make.trailing.bottom.mas_equalTo(self);
    }];
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    TypeModel *typeModel = self.typeTitleArray[self.tableViewCurrentSelectedIndexPath.row];
    SearchResultViewController *vc = [[SearchResultViewController alloc] initWithDataArray:@[] type:[NSNull null] categoryName:typeModel.categoryName keyWords:[NSNull null]];
    vc.hidesBottomBarWhenPushed = YES;
    [self.myViewController.navigationController pushViewController:vc animated:YES];
    return NO;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (![Tool isPoint:point inFrame:self.searchBar.frame]) {
        [self.searchBar resignFirstResponder];
    }
    return [super hitTest:point withEvent:event];
}
@end
