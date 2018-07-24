//
//  SearchResult.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/21.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "SearchResult.h"
#import "MerchandiseViewController.h"
@interface SearchResult()<UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIImageView *haveNoDataIMGV;
@property (nonatomic, strong) UILabel *haveNoDataLabel;
@end

@implementation SearchResult
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    self.substitutionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width,65)];
    self.substitutionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.substitutionView];
    
    UIView *substitutionViewLine = [[UIView alloc] init];
    substitutionViewLine.backgroundColor = INSETCOLOR_F5;
    [self.substitutionView addSubview:substitutionViewLine];
    [substitutionViewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(self.substitutionView);
        make.height.mas_equalTo(1);
    }];
    
    self.searchBar = [[BaseSearchBar alloc] init];
    self.searchBar.layer.borderColor = COLOR_RGB16(0xe5e5e5).CGColor;
    self.searchBar.layer.borderWidth = 1;
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"搜索商品";
    for (UIView *subView in self.searchBar.subviews) {
        if ([subView isKindOfClass:[UIView  class]]) {
            [[subView.subviews objectAtIndex:0] removeFromSuperview];
        }
    }
    [self.substitutionView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(260));
        make.height.mas_equalTo(34);
        make.bottom.mas_equalTo(self.substitutionView).offset(0);
        make.centerX.mas_equalTo(self.substitutionView);
    }];
    
    UIButton *searchButton = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@"搜索"];
    [self.substitutionView addSubview:searchButton];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.searchBar.mas_trailing).offset(5);
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(5));
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.searchBar);
    }];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"返回键"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.substitutionView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.substitutionView).offset(CUSTOM_WIDTH(14));
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(16);
        make.centerY.mas_equalTo(self.searchBar);
    }];
    
    
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [self.mainCollectionView registerClass:[MerchandiseCollectionViewCell class] forCellWithReuseIdentifier:@"MerchandiseCollectionViewCell"];
    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    [self addSubview:self.mainCollectionView];
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self);
        make.top.mas_equalTo(self.substitutionView.mas_bottom);
    }];
    
    self.haveNoDataIMGV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"订单空"]];
    self.haveNoDataIMGV.hidden = YES;
    [self addSubview:self.haveNoDataIMGV];
    [self.haveNoDataIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(138);
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-15);
    }];
    
    self.haveNoDataLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"暂无商品"];
    self.haveNoDataLabel.hidden = YES;
    [self addSubview:self.haveNoDataLabel];
    [self.haveNoDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.haveNoDataIMGV.mas_bottom).offset(10);
    }];
    [self bringSubviewToFront:self.substitutionView];
}

- (void)backAction:(UIButton *)sender{
    [self.myViewController.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [((SearchResultViewController *)self.myViewController) getPageDataWithKeywords:searchBar.text withPage:1];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(1, 0, 1, 0);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.bounds.size.width/2 - 0.5, (self.bounds.size.width/2 - 0.5)/188 * 210);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MerchandiseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MerchandiseCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    if (dataArray.count == 0) {
        self.haveNoDataLabel.hidden = NO;
        self.haveNoDataIMGV.hidden = NO;
    }else{
        self.haveNoDataLabel.hidden = YES;
        self.haveNoDataIMGV.hidden = YES;
    }
    [self.mainCollectionView reloadData];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    MerchandiseModel *model = self.dataArray[indexPath.row];
    MerchandiseViewController *vc = [[MerchandiseViewController alloc] initWithMerchandiseID:[NSString stringWithFormat:@"%ld",model.ID.integerValue]];
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (![Tool isPoint:point inFrame:self.searchBar.frame]) {
        [self.searchBar resignFirstResponder];
    }
    return [super hitTest:point withEvent:event];
}

- (void)searchAction:(UIButton *)sender{
    if (self.searchBar.text.length > 0) {
        [self searchBarSearchButtonClicked:self.searchBar];
    }
}
@end
