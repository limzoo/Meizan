//
//  ItemCollectionView.m
//  JingXuan
//
//  Created by sfs on 2017/12/11.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "ItemCollectionView.h"
#import "ItemCollectionViewCell.h"
@interface ItemCollectionView()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *sizeArray;
@end
@implementation ItemCollectionView
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.titlesArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *currentString = self.titlesArray[indexPath.row];
    switch (self.type) {
        case ItemCollectionViewItemTypeBorder:{
            CGSize size = [currentString sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14]}];
            [self.sizeArray addObject:[NSValue valueWithCGSize:size]];
            return size;
            break;
        }
        case ItemCollectionViewItemTypePoint:{
            CGSize size = [currentString sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14]}];
            
            return CGSizeMake(size.width + 30, size.height);
            break;
            
        }
        default:
            break;
    }
     return CGSizeZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCollectionViewCell" forIndexPath:indexPath];
    cell.type = self.type;
    cell.titleString = self.titlesArray[indexPath.row];
    cell.textColor = self.textColor;
    cell.borderColor = self.borderColor;
    return cell;
}

- (void)createSubview{
    [self registerClass:[ItemCollectionViewCell class] forCellWithReuseIdentifier:@"ItemCollectionViewCell"];
    self.delegate = self;
    self.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
}

- (NSMutableArray *)sizeArray{
    if (!_sizeArray) {
        _sizeArray = [NSMutableArray array];
    }
    return _sizeArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
