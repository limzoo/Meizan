//
//  BlockDetailView.m
//  MeiZan
//
//  Created by 林宇 on 2018/2/9.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BlockDetailView.h"
#import "MerchandiseViewController.h"
#import "HP_MerchandiseCollectionViewCell.h"
@interface BlockDetailView()<UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UIImageView *haveNoDataIMGV;
@property (nonatomic, strong) UILabel *haveNoDataLabel;
@end
@implementation BlockDetailView
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    [self.mainCollectionView registerClass:[HP_MerchandiseCollectionViewCell class] forCellWithReuseIdentifier:@"HP_MerchandiseCollectionViewCell"];
    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    [self addSubview:self.mainCollectionView];
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.top.mas_equalTo(self);
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
     return CGSizeMake(self.bounds.size.width, 112);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HP_MerchandiseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HP_MerchandiseCollectionViewCell" forIndexPath:indexPath];
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
@end
