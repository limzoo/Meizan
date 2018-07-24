//
//  MerchantDetailView.m
//  JingXuan
//
//  Created by sfs on 2017/12/12.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MerchantDetailView.h"
#import "MerchantDetailCollectionViewCell.h"
#import "MerchantSelectTypeCollectionReusableView.h"
#import "MerchandiseCollectionViewCell.h"
@interface MerchantDetailView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MerchantSelectTypeDelegate>
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@end
@implementation MerchantDetailView
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.sectionHeadersPinToVisibleBounds = YES;
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.mainCollectionView.backgroundColor = INSETCOLOR_F5;
    
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    [self.mainCollectionView registerClass:[MerchantDetailCollectionViewCell class] forCellWithReuseIdentifier:@"MerchantDetailCollectionViewCell"];
    [self.mainCollectionView registerClass:[MerchandiseCollectionViewCell class] forCellWithReuseIdentifier:@"MerchandiseCollectionViewCell"];
    [self.mainCollectionView registerClass:[MerchantSelectTypeCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MerchantSelectTypeCollectionReusableView"];
    [self addSubview:self.mainCollectionView];
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.trailing.mas_equalTo(self);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 10;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            MerchantDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MerchantDetailCollectionViewCell" forIndexPath:indexPath];
            return cell;
            break;
        }
        case 1:{
            MerchandiseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MerchandiseCollectionViewCell" forIndexPath:indexPath];
            return cell;
            break;
        }
        default:
            break;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return CGSizeMake(self.bounds.size.width, 336);
            break;
        case 1:
            return CGSizeMake(self.bounds.size.width/2 - 0.5, 232);
        default:
            break;
    }
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    switch (section) {
        case 1:
            return UIEdgeInsetsMake(0, 0, 0, 1);
            break;
            
        default:
            break;
    }
    return UIEdgeInsetsZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (indexPath.section == 1) {
            MerchantSelectTypeCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MerchantSelectTypeCollectionReusableView" forIndexPath:indexPath];
            view.delegate = self;
            return view;
        }
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 1:
            return CGSizeMake(self.bounds.size.width, 44);
            break;
            
        default:
            break;
    }
    return CGSizeZero;
}
- (void)selectedViewDidSelectedIndex:(NSUInteger)index lastIndex:(NSUInteger)lastIndex{
    [self.mainCollectionView setContentOffset:CGPointMake(0, 336) animated:YES];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
