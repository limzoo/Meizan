//
//  MerchandiseSelectType.m
//  JingXuan
//
//  Created by sfs on 2017/12/13.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MerchandiseSelectType.h"
#import "MerchandiseSelectTypeHeadCollectionViewCell.h"
#import "ItemCollectionViewCell.h"
#import "MerchandiseDetailCollectionReusableView.h"
#import "MerchandiseTypeModel.h"
#import "MerchandiseChangeNumButtonCollectionViewCell.h"
#import "MerchandiseSelectTypeViewController.h"
#import "MakeOrderViewController.h"
@interface MerchandiseSelectType()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSMutableDictionary *selectIndexPathDic;
@property (nonatomic, strong) UICollectionView *mainCollectonView;

@property (nonatomic, strong) NSString *didChooseTypeStr;
@property (nonatomic, assign) long selectNum;
@property (nonatomic, strong) UIButton *addToShopCart;
@end
@implementation MerchandiseSelectType
- (void)configInitial{
    self.selectNum = 1;
    self.didChooseTypeStr = @"";
}
- (void)createSubview{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.mainCollectonView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.mainCollectonView.backgroundColor = [UIColor whiteColor];
    self.mainCollectonView.delegate = self;
    self.mainCollectonView.dataSource = self;
    [self.mainCollectonView registerClass:[MerchandiseSelectTypeHeadCollectionViewCell class] forCellWithReuseIdentifier:@"MerchandiseSelectTypeHeadCollectionViewCell"];
    [self.mainCollectonView registerClass:[ItemCollectionViewCell class] forCellWithReuseIdentifier:@"ItemCollectionViewCell"];
    [self.mainCollectonView registerClass:[MerchandiseChangeNumButtonCollectionViewCell class] forCellWithReuseIdentifier:@"MerchandiseChangeNumButtonCollectionViewCell"];
    [self.mainCollectonView registerClass:[MerchandiseDetailCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MerchandiseDetailCollectionReusableView"];
    [self addSubview:self.mainCollectonView];
    [self.mainCollectonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self);
    }];
    
    self.addToShopCart = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:0 fontSize:16 title:@"加入购物车"];
    [ self.addToShopCart addTarget:self action:@selector(addToShopCart:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview: self.addToShopCart];
    [ self.addToShopCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.mainCollectonView.mas_bottom);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count + 1 + 1; //加一个数量 加一个头
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //    if (section == self.dataArray.count) {
    //        return 1;
    //    }
    //    return ((NSArray *)self.dataArray[section]).count;
    if (section == 0) {
        return 1;
    }else if(section ==  self.dataArray.count + 1){
        return 1;
    }else{
        return ((NSArray *)self.dataArray[section - 1]).count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MerchandiseSelectTypeHeadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MerchandiseSelectTypeHeadCollectionViewCell" forIndexPath:indexPath];
        cell.imgUrl = self.model.showImageUrl;
        cell.priceText = [NSString stringWithFormat:@"价格:¥%.2f",self.model.price.floatValue];
        if (self.didChooseTypeStr.length == 0) {
            cell.selectType.text = @"请选择规格属性";
        }else{
            cell.selectType.text = self.didChooseTypeStr;
        }
        return cell;
    }
    else if (indexPath.section == self.dataArray.count + 1){
        MerchandiseChangeNumButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MerchandiseChangeNumButtonCollectionViewCell" forIndexPath:indexPath];
        __weak typeof(self) weakSelf = self;
        cell.changeSelectNum = ^(NSUInteger num) {
            weakSelf.selectNum = num;
        };
        return cell;
    }else{
        ItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCollectionViewCell" forIndexPath:indexPath];
        cell.type = ItemCollectionViewItemTypeBorder;
        MerchandiseTypeModel *model = ((NSArray *)self.dataArray[indexPath.section - 1])[indexPath.row];
        cell.titleString = model.SPECS_NAME;
        NSIndexPath *selectedIndex = [self.selectIndexPathDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
        if (selectedIndex != nil) {
            if (selectedIndex.row != indexPath.row) {
                cell.textColor = TEXTCOLOR;
                cell.borderColor = COLOR_RGB16(0x979797);
            }else{
                cell.textColor = STYLECOLOR;
                cell.borderColor = STYLECOLOR;
            }
        }else{
            cell.textColor = TEXTCOLOR;
            cell.borderColor = COLOR_RGB16(0x979797);
        }
        return cell;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(self.bounds.size.width, 100);
    }else if (indexPath.section == self.dataArray.count + 1){
        return CGSizeMake(126, 24);
    }else{
        MerchandiseTypeModel *model = ((NSArray *)self.dataArray[indexPath.section - 1])[indexPath.row];
       NSString *str = model.SPECS_NAME;
        CGSize size =  [str sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14]}];
        return CGSizeMake(size.width + 10, size.height + 6);
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section != 0 ) {
        return UIEdgeInsetsMake(0, 14, 8, 14);
    }
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section != 0) {
        return CGSizeMake(self.bounds.size.width, 38);
    }
    return CGSizeZero;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        MerchandiseDetailCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MerchandiseDetailCollectionReusableView" forIndexPath:indexPath];
        if (indexPath.section == self.dataArray.count + 1) {
            view.titleLabel.text = @"数量";
        }else{
            MerchandiseTypeModel *model = ((NSArray *)self.dataArray[indexPath.section - 1])[indexPath.row];
            view.titleLabel.text = model.SPECS_TITLE;
        }
        return view;
    }
    return nil;
}

- (NSMutableDictionary *)selectIndexPathDic{
    if (!_selectIndexPathDic) {
        _selectIndexPathDic = [NSMutableDictionary dictionary];
    }
    return _selectIndexPathDic;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0 && indexPath.section != self.dataArray.count + 1) {
        [self.selectIndexPathDic setObject:indexPath forKey:[NSString stringWithFormat:@"%ld",indexPath.section]];
        NSString *selectId = @"";
        NSString *tempStr = @"";
        for (NSIndexPath *indexPath in [self.selectIndexPathDic allValues]) {
            MerchandiseTypeModel *model = ((NSArray *)self.dataArray[indexPath.section - 1])[indexPath.row];
            tempStr = [ tempStr stringByAppendingString:[NSString stringWithFormat:@"%@", model.SPECS_NAME]];
            if (selectId.length == 0) {
                selectId = model.SPECS_ID;
            }else{
                selectId = [selectId stringByAppendingString:[NSString stringWithFormat:@",%@",model.SPECS_ID]];
            }
        }
        [((MerchandiseSelectTypeViewController *) self.myViewController) getMerchandiseMessageWithSpecsId:selectId goodsId:self.model.merchandiseId];
        self.didChooseTypeStr = [NSString stringWithFormat:@"已选规格: %@",tempStr];
        [collectionView reloadData];
    }
}

- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [_mainCollectonView reloadData];
}

- (void)setModel:(MerchandiseDetailModel *)model{
    _model = [[MerchandiseDetailModel alloc] init];
    _model = model;
    [_mainCollectonView reloadData];
}

- (void)setSelectModel:(MerchandiseSelectResultModel *)selectModel{
    _selectModel = selectModel;
    self.didChooseTypeStr = [self.didChooseTypeStr stringByAppendingString:[NSString stringWithFormat:@",库存:%ld",selectModel.stockCount]];
     [_mainCollectonView reloadData];
}
- (void)addToShopCart:(UIButton *)sender{
    [self endEditing:YES];
    if (!self.selectModel) {
        [Tool showMessage:@"请选择规格" duration:3];
        return;
    }
    NSString *skuId;
    for (NSIndexPath *indexPath in [self. selectIndexPathDic allValues]) {
         MerchandiseTypeModel *model = ((NSArray *)self.dataArray[indexPath.section - 1])[indexPath.row];
        if (skuId.length > 0) {
            skuId = [skuId stringByAppendingString:[NSString stringWithFormat:@",%@",model.SPECS_ID]];
        }else{
            skuId = [NSString stringWithFormat:@"%@",model.SPECS_ID];
        }
    }
    if (self.type == 0) {
    [((MerchandiseSelectTypeViewController *)self.myViewController) addToShopCartWithNumber:self.selectNum];
    }else if(self.type == 1){
        MakeOrderViewController *vc = [[MakeOrderViewController alloc] initWithSkuId:[NSString stringWithFormat:@"%ld", self.selectModel.selectMerchandiseId] number:[NSString stringWithFormat:@"%ld",self.selectNum]];
        vc.merchandiseArray = [NSMutableArray arrayWithObject:self.selectModel];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"removeSelectPage" object:nil];
        [((MerchandiseSelectTypeViewController *)self.myViewController).baseVC.navigationController pushViewController:vc animated:YES];
    }else if(self.type == 2){
        [((MerchandiseSelectTypeViewController *)self.myViewController) changeMerchandise:self.shopCartId skuId:[NSString stringWithFormat:@"%ld",self.selectModel.selectMerchandiseId] selectNum:self.selectNum];
    }
}

- (void)setType:(NSInteger)type{
    _type = type;
    if (type == 0) {
        [self.addToShopCart setTitle:@"加入购物车" forState:UIControlStateNormal];
    }else if(type == 1){
        [self.addToShopCart setTitle:@"立即购买" forState:UIControlStateNormal];
    }else if (type == 2){
        [self.addToShopCart setTitle:@"完成" forState:UIControlStateNormal];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    [self endEditing:YES];
    return [super hitTest:point withEvent:event];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
