//
//  OrderMerchandiseListView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/29.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "OrderMerchandiseListView.h"
#import "OrderMerchandiseCollectionViewCell.h"
@interface OrderMerchandiseListView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@end
@implementation OrderMerchandiseListView
- (void)createSubview{
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    
    self.mainCollectionView.backgroundColor = [UIColor whiteColor];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    [self.mainCollectionView registerClass:[OrderMerchandiseCollectionViewCell class] forCellWithReuseIdentifier:@"OrderMerchandiseCollectionViewCell"];
    [self addSubview:self.mainCollectionView];
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.trailing.mas_equalTo(self);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.merchandiseArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.bounds.size.width, 110);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OrderMerchandiseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OrderMerchandiseCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.merchandiseArray[indexPath.row];
    return cell;
}

- (void)setMerchandiseArray:(NSArray *)merchandiseArray{
    _merchandiseArray = merchandiseArray;
    [self.mainCollectionView reloadData];
}

@end
