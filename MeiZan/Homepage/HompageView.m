//
//  HompageView.m
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "HompageView.h"
#import "HP_MerchandiseCollectionViewCell.h"
#import "MerchandiseCollectionViewCell.h"
#import "HP_ADCollectionViewCell.h"
#import "HP_blockCollectionViewCell.h"
#import "MerchandiseCollectionViewCell.h"
#import "MerchandiseViewController.h"
#import "MerchantDetailViewController.h"
#import "HP_ScrollingTitleCollectionViewCell.h"
#import "RankPageViewController.h"
#import "BaseSearchBar.h"
#import "HomepageViewController.h"
#import "MyOrderViewController.h"
#import "SearchResultViewController.h"
#import "RankDetailModel.h"
#import "RankDetailTableViewCell.h"
#import "HeadCollectionReusableView.h"
#import "ADModel.h"
#import "FullImageCollectionViewCell.h"

@interface HompageView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton *rankSureButton;
@end

@implementation HompageView
#pragma mark -<colleciton协议>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 8;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:{
            NSArray *merchantDiseArray = [self.listMerchandiseDict objectForKey:@"goodsTjList"];
            if (merchantDiseArray.count != 0) {
                return 1 + merchantDiseArray.count;
            }else{
                return 0;
            }
            break;
        }
        case 4:{
            NSArray *merchantDiseArray = [self.listMerchandiseDict objectForKey:@"goodsYhList"];
            if (merchantDiseArray.count != 0) {
                 return 1 + merchantDiseArray.count;
            }else{
                return 0;
            }
            break;
        }
        case 5:{
            NSArray *merchantDiseArray = [self.listMerchandiseDict objectForKey:@"goodsXpList"];
            if (merchantDiseArray.count != 0) {
                return 1 + merchantDiseArray.count;
            }else{
                return 0;
            }
            break;
        }
        case 6:{
            NSArray *merchantDiseArray = [self.listMerchandiseDict objectForKey:@"goodsJfList"];
            if (merchantDiseArray.count != 0) {
                return 1 + merchantDiseArray.count;
            }else{
                return 0;
            }
            break;
        }
        case 7:
            return self.merchandiseArray.count;
            break;
        default:
            break;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            HP_ADCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HP_ADCollectionViewCell" forIndexPath:indexPath];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (ADModel *model in self.ADArray) {
                if (model.adPositionId.integerValue == 1) {
                    [tempArray addObject:model];
                }
            }
            cell.ADArray = tempArray;
            return cell;
            break;
        }
        case 1:{
            HP_ScrollingTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HP_ScrollingTitleCollectionViewCell" forIndexPath:indexPath];
            cell.myViewcontroller = self.myViewController;
            [cell.arrowIMGV addTarget:self action:@selector(moveToRankPage:) forControlEvents:UIControlEventTouchUpInside];
            cell.newsArray = self.scrollingTitlesArray;
            [cell createScrollTimer];
            return cell;
            break;
        }
        case 2:{
            HP_blockCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HP_blockCollectionViewCell" forIndexPath:indexPath];
            for (int i = 0; i < 4; i++) {
                UIButton *button = [cell viewWithTag:(i + 100)];
                [button addTarget:self action:@selector(moveToDetailPage:) forControlEvents:UIControlEventTouchUpInside];
            }
            return cell;
            break;
        }
        case 3:{
            if (indexPath.row == 0) {
                FullImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FullImageCollectionViewCell" forIndexPath:indexPath];
                for (ADModel *model in self.ADArray) {
                    if ([model.title isEqualToString:@"热门产品"]) {
                        cell.photoUrl = model.imageUrl;
                        break;
                    }
                }
                return cell;
            }
            MerchandiseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MerchandiseCollectionViewCell" forIndexPath:indexPath];
            cell.model = [MerchandiseModel yy_modelWithDictionary:[self.listMerchandiseDict objectForKey:@"goodsTjList"][indexPath.row - 1]];
            return cell;
            break;
        }
        case 4:{
            if (indexPath.row == 0) {
                FullImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FullImageCollectionViewCell" forIndexPath:indexPath];
                for (ADModel *model in self.ADArray) {
                    if ([model.title isEqualToString:@"特价促销"]) {
                        cell.photoUrl = model.imageUrl;
                        break;
                    }
                }
                return cell;
            }
            MerchandiseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MerchandiseCollectionViewCell" forIndexPath:indexPath];
            cell.model = [MerchandiseModel yy_modelWithDictionary:[self.listMerchandiseDict objectForKey:@"goodsYhList"][indexPath.row - 1]];
            return cell;
            break;
        }
        case 5:{
            if (indexPath.row == 0) {
                FullImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FullImageCollectionViewCell" forIndexPath:indexPath];
                for (ADModel *model in self.ADArray) {
                    if ([model.title isEqualToString:@"新品上架"]) {
                        cell.photoUrl = model.imageUrl;
                        break;
                    }
                }
                return cell;
            }
            MerchandiseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MerchandiseCollectionViewCell" forIndexPath:indexPath];
            cell.model = [MerchandiseModel yy_modelWithDictionary:[self.listMerchandiseDict objectForKey:@"goodsXpList"][indexPath.row - 1]];
            return cell;
            break;
        }
        case 6:{
            if (indexPath.row == 0) {
                FullImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FullImageCollectionViewCell" forIndexPath:indexPath];
                for (ADModel *model in self.ADArray) {
                    if ([model.title isEqualToString:@"积分兑换"]) {
                        cell.photoUrl = model.imageUrl;
                        break;
                    }
                }
                return cell;
            }
            MerchandiseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MerchandiseCollectionViewCell" forIndexPath:indexPath];
            cell.model = [MerchandiseModel yy_modelWithDictionary:[self.listMerchandiseDict objectForKey:@"goodsJfList"][indexPath.row - 1]];
            return cell;
            break;
        }
        case 7:{
            HP_MerchandiseCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HP_MerchandiseCollectionViewCell" forIndexPath:indexPath];
            cell.model = self.merchandiseArray[indexPath.row];
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
        case 0:{
            return CGSizeMake(self.bounds.size.width, self.bounds.size.width/375 * 150);
            break;
        }
        case 1:{
            return CGSizeMake(self.bounds.size.width, 50);
            break;
        }
        case 2:{
            return CGSizeMake(self.bounds.size.width, 116);
            break;
        }
        case 3:{
            if (indexPath.row == 0) {
                return CGSizeMake(self.bounds.size.width, 140);
            }
            return CGSizeMake(self.bounds.size.width/2 - 0.5, (self.bounds.size.width/2 - 0.5)/188 * 210);
            break;
        }
        case 4:{
            if (indexPath.row == 0) {
                return CGSizeMake(self.bounds.size.width, 140);
            }
            return CGSizeMake(self.bounds.size.width/2 - 0.5, (self.bounds.size.width/2 - 0.5)/188 * 210);
            break;
        }
        case 5:{
            if (indexPath.row == 0) {
                return CGSizeMake(self.bounds.size.width, 140);
            }
            return CGSizeMake(self.bounds.size.width/2 - 0.5, (self.bounds.size.width/2 - 0.5)/188 * 210);
            break;
        }
        case 6:{
            if (indexPath.row == 0) {
                return CGSizeMake(self.bounds.size.width, 140);
            }
            return CGSizeMake(self.bounds.size.width/2 - 0.5, (self.bounds.size.width/2 - 0.5)/188 * 210);
            break;
        }
        case 7:{
            return CGSizeMake(self.bounds.size.width, 112);
            break;
        }
        default:
            break;
    }
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    switch (section) {
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
            break;
        case 5:
            return 1;
            break;
        case 6:
            return 1;
            break;
        case 7:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    switch (section) {
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
            break;
        case 5:
            return 1;
            break;
        case 6:
            return 1;
            break;
        case 7:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    switch (section) {
        case 0:
            return UIEdgeInsetsMake(0, 0, 0, 0);
            break;
        case 1:
            return UIEdgeInsetsMake(0, 0, 0, 0);
            break;
        case 2:
            return UIEdgeInsetsMake(1, 0, 8, 0);
            break;
        case 3:
            return UIEdgeInsetsMake(1, 0, 8, 0);
            break;
        case 4:
            return UIEdgeInsetsMake(1, 0, 8, 0);
            break;
        case 5:
            return UIEdgeInsetsMake(1, 0, 8, 0);
            break;
        case 6:
            return UIEdgeInsetsMake(1, 0, 8, 0);
            break;
        case 7:
            return UIEdgeInsetsMake(1, 0, 1, 0);
            break;
        default:
            break;
    }
    return UIEdgeInsetsZero;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 2:{
            MerchantDetailViewController *vc = [[MerchantDetailViewController alloc] init];
            self.myViewController.navigationController.navigationBar.hidden = NO;
            vc.hidesBottomBarWhenPushed = YES;
            [self.myViewController.navigationController pushViewController:vc animated:YES];
        }
        case 3:{
            if (indexPath.row == 0) {
                for (ADModel *adModel in self.ADArray) {
                    if ([adModel.title isEqualToString:@"热门产品"]) {
                        if ([adModel.linkUrl containsString:@"http"]) {
                            ;
                        }else if (adModel.linkUrl != nil && adModel.linkUrl.length != 0){
                            MerchandiseViewController *vc = [[MerchandiseViewController alloc] initWithMerchandiseID:adModel.linkUrl ];
                            vc.hidesBottomBarWhenPushed = YES;
                            [self.myViewController.navigationController pushViewController:vc animated:YES];
                        }
                        break;
                    }
                }
                return;
            }
            MerchandiseModel *model = [MerchandiseModel yy_modelWithDictionary:[self.listMerchandiseDict objectForKey:@"goodsTjList"][indexPath.row - 1]];
            MerchandiseViewController *vc = [[MerchandiseViewController alloc] initWithMerchandiseID:[NSString stringWithFormat:@"%ld",model.ID.integerValue]];
            vc.hidesBottomBarWhenPushed = YES;
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 4:{
            if (indexPath.row == 0) {
                for (ADModel *adModel in self.ADArray) {
                    if ([adModel.title isEqualToString:@"特价促销"]) {
                        if ([adModel.linkUrl containsString:@"http"]) {
                            ;
                        }else if (adModel.linkUrl != nil && adModel.linkUrl.length != 0){
                            MerchandiseViewController *vc = [[MerchandiseViewController alloc] initWithMerchandiseID:adModel.linkUrl ];
                             vc.hidesBottomBarWhenPushed = YES;
                            [self.myViewController.navigationController pushViewController:vc animated:YES];
                        }
                        break;
                    }
                }
                return;
            }
            MerchandiseModel *model = [MerchandiseModel yy_modelWithDictionary:[self.listMerchandiseDict objectForKey:@"goodsYhList"][indexPath.row - 1]];
            MerchandiseViewController *vc = [[MerchandiseViewController alloc] initWithMerchandiseID:[NSString stringWithFormat:@"%ld",model.ID.integerValue]];
            vc.hidesBottomBarWhenPushed = YES;
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 5:{
            if (indexPath.row == 0) {
                for (ADModel *adModel in self.ADArray) {
                    if ([adModel.title isEqualToString:@"新品上架"]) {
                        if ([adModel.linkUrl containsString:@"http"]) {
                            ;
                        }else if (adModel.linkUrl != nil && adModel.linkUrl.length != 0){
                            MerchandiseViewController *vc = [[MerchandiseViewController alloc] initWithMerchandiseID:adModel.linkUrl ];
                             vc.hidesBottomBarWhenPushed = YES;
                            [self.myViewController.navigationController pushViewController:vc animated:YES];
                        }
                          break;
                    }
                }
                return;
            }
            MerchandiseModel *model = [MerchandiseModel yy_modelWithDictionary:[self.listMerchandiseDict objectForKey:@"goodsXpList"][indexPath.row - 1]];
            MerchandiseViewController *vc = [[MerchandiseViewController alloc] initWithMerchandiseID:[NSString stringWithFormat:@"%ld",model.ID.integerValue]];
            vc.hidesBottomBarWhenPushed = YES;
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 6:{
            if (indexPath.row == 0) {
                for (ADModel *adModel in self.ADArray) {
                    if ([adModel.title isEqualToString:@"积分兑换"]) {
                        if ([adModel.linkUrl containsString:@"http"]) {
                            ;
                        }else if (adModel.linkUrl != nil && adModel.linkUrl.length != 0){
                            MerchandiseViewController *vc = [[MerchandiseViewController alloc] initWithMerchandiseID:adModel.linkUrl ];
                             vc.hidesBottomBarWhenPushed = YES;
                            [self.myViewController.navigationController pushViewController:vc animated:YES];
                        }
                          break;
                    }
                }
                
                return;
            }
            MerchandiseModel *model = [MerchandiseModel yy_modelWithDictionary:[self.listMerchandiseDict objectForKey:@"goodsJfList"][indexPath.row - 1]];
            MerchandiseViewController *vc = [[MerchandiseViewController alloc] initWithMerchandiseID:[NSString stringWithFormat:@"%ld",model.ID.integerValue]];
            vc.hidesBottomBarWhenPushed = YES;
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 7:{
            MerchandiseModel *model = self.merchandiseArray[indexPath.row];
            MerchandiseViewController *vc = [[MerchandiseViewController alloc] initWithMerchandiseID:[NSString stringWithFormat:@"%ld",model.ID.integerValue]];
            vc.hidesBottomBarWhenPushed = YES;
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)moveToDetailPage:(UIButton *)sender{
    NSArray *tempArray = @[@"goods_tj",@"goods_yh",@"goods_xp",@"jifen"];//jifen这个是自己写的,所以到了第二个界面后获取数据方式其实是不同的
    [((HomepageViewController *)self.myViewController) getPageDataMoveToPageWithgoodsName:[NSNull null] categoryName:[NSNull null] minimumPrice:0 maximumPrice:9999 style:tempArray[sender.tag - 100] orderBy:[NSNull null] keywords:[NSNull null] page:@1];
}

- (void)createSubview{
    self.substitutionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width,65)];
    
    self.substitutionView.backgroundColor =  [UIColor colorWithRed:246/255.0 green:171/255.0 blue:0/255.0 alpha:0];;
    [self addSubview:self.substitutionView];
    
    self.searchBar = [[BaseSearchBar alloc] init];
    self.searchBar = [[BaseSearchBar alloc] init];
    self.searchBar.delegate =self;
    self.searchBar.placeholder = @"  搜索商品";
    self.searchBar.tintColor = [UIColor clearColor];
    self.searchBar.layer.borderColor = COLOR_RGB16(0xf5f5f5).CGColor;
    self.searchBar.layer.borderWidth = 1;
    for (UIView *subView in self.searchBar.subviews) {
        if ([subView isKindOfClass:[UIView  class]]) {
            [[subView.subviews objectAtIndex:0] removeFromSuperview];
        }
    }
    [self.substitutionView addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.height.mas_equalTo(33);
        make.top.mas_equalTo(self.substitutionView).offset(26);
        make.centerX.mas_equalTo(self.substitutionView);
    }];
    
    UIView *substitutionViewLine = [[UIView alloc] init];
    substitutionViewLine.backgroundColor = INSETCOLOR_F5;
    [self.substitutionView addSubview:substitutionViewLine];
    [substitutionViewLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(self.substitutionView);
        make.height.mas_equalTo(1);
    }];
    
    self.mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
    self.mainCollectionView.backgroundColor = INSETCOLOR_F5;
    [self addSubview:self.mainCollectionView];
    self.mainCollectionView.delegate = self;
    self.mainCollectionView.dataSource = self;
    [self.mainCollectionView registerClass:[MerchandiseCollectionViewCell class] forCellWithReuseIdentifier:@"MerchandiseCollectionViewCell"];
    [self.mainCollectionView registerClass:[HP_ADCollectionViewCell class] forCellWithReuseIdentifier:@"HP_ADCollectionViewCell"];
    [self.mainCollectionView registerClass:[FullImageCollectionViewCell class] forCellWithReuseIdentifier:@"FullImageCollectionViewCell"];
    [self.mainCollectionView registerClass:[HP_blockCollectionViewCell class] forCellWithReuseIdentifier:@"HP_blockCollectionViewCell"];
    [self.mainCollectionView registerClass:[HP_ScrollingTitleCollectionViewCell class] forCellWithReuseIdentifier:@"HP_ScrollingTitleCollectionViewCell"];
    [self.mainCollectionView registerClass:[HP_MerchandiseCollectionViewCell class] forCellWithReuseIdentifier:@"HP_MerchandiseCollectionViewCell"];
    [self.mainCollectionView registerClass:[HeadCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadCollectionReusableView"];
    [self.mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
        make.top.mas_equalTo(substitutionViewLine.mas_bottom);
    }];
    if (@available(iOS 11.0, *)) {
        self.mainCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self bringSubviewToFront:self.substitutionView];
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeadCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadCollectionReusableView" forIndexPath:indexPath];
        NSArray *temp = @[@"热门产品",@"特价促销",@"新品上架",@"积分兑换",@"更多商品"];
        view.tag = indexPath.section;
        
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fromHeadMoveToMorePage:)]];
        view.headTitleLabel.text = temp[indexPath.section - 3];
        if (indexPath.section == 7) {
            view.arrowImg.hidden = YES;
            view.moreLabel.hidden = YES;
        }else{
            view.arrowImg.hidden = NO;
            view.moreLabel.hidden = NO;
        }
        return view;
    }
    return nil;
}
- (void)fromHeadMoveToMorePage:(UITapGestureRecognizer *)tap{
    if (tap.view.tag == 7) {
        return;
    }
    NSArray *tempArray = @[@"goods_tj",@"goods_yh",@"goods_xp",@"jifen",[NSNull null]];//新品这个是自己写的,所以到了第二个界面后获取数据方式其实是不同的
    [((HomepageViewController *)self.myViewController) getPageDataMoveToPageWithgoodsName:[NSNull null] categoryName:[NSNull null] minimumPrice:0 maximumPrice:9999 style:tempArray[tap.view.tag - 3] orderBy:[NSNull null] keywords:[NSNull null] page:@1];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
            return CGSizeMake(self.bounds.size.width, 46);
            break;
        default:
            break;
    }
    return CGSizeZero;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    SearchResultViewController *vc = [[SearchResultViewController alloc] initWithDataArray:@[] type:@"" categoryName:@"" keyWords:@""];
    vc.hidesBottomBarWhenPushed = YES;
    [self.myViewController.navigationController pushViewController:vc animated:YES];
    return NO;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.substitutionView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:(scrollView.contentOffset.y - self.bounds.size.width/375 * 150 + 65)/33.0];
    self.searchBar.layer.borderColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:(scrollView.contentOffset.y - self.bounds.size.width/375 * 150 + 65)/33.0].CGColor;
}

- (void)setScrollingTitlesArray:(NSArray *)scrollingTitlesArray{
    _scrollingTitlesArray = scrollingTitlesArray;
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
        if (_scrollingTitlesArray.count != 0 && config != nil) {
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                UserMessageModel *model = [scrollingTitlesArray firstObject];
                [((HomepageViewController *)self.myViewController) loadRankDetailWithTitle:model.MESSAGE_TITLE];
            });
        }
    dispatch_async(dispatch_get_main_queue(), ^{
        [_mainCollectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
    });
    
}
- (void)setRankArray:(NSArray *)rankArray{
    _rankArray = rankArray;
    self.masksView = [[UIView alloc] init];
    self.maskView.alpha = 0;
    self.masksView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.masksView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeMask)]];
    [[UIApplication sharedApplication].keyWindow addSubview:self.masksView];
    self.masksView.tag = 700;
    [self.masksView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo([UIApplication sharedApplication].keyWindow);
        make.bottom.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
    
    UIImageView *homepageRank = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"homepageRank"]];
    homepageRank.userInteractionEnabled = YES;
    [self.masksView addSubview:homepageRank];
    [homepageRank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.masksView);
        make.leading.mas_equalTo(self.masksView).offset(CUSTOM_WIDTH(10));
        make.height.mas_equalTo(homepageRank.mas_width).multipliedBy(395/300.0);
        make.centerY.mas_equalTo(self.masksView).offset(-10);
    }];
    
    self.rankSureButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:COLOR_RGB16(0xff4239) cornerRadius:3 fontSize:14 title:@"确定"];
    [self.rankSureButton addTarget: self action:@selector(removeMask) forControlEvents:UIControlEventTouchUpInside];
    [homepageRank addSubview:self.rankSureButton];
    [self.rankSureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(100));
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(homepageRank);
        make.bottom.mas_equalTo(homepageRank).offset(-40);
    }];
    
    UITableView *tableView = [[UITableView alloc] init];
    [tableView registerClass:[RankDetailTableViewCell class] forCellReuseIdentifier:@"RankDetailTableViewCell"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [homepageRank addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(homepageRank);
        make.leading.mas_equalTo(homepageRank).offset(CUSTOM_WIDTH(45));
        make.top.mas_equalTo(homepageRank).offset(110);
        make.bottom.mas_equalTo(self.rankSureButton.mas_top).offset(-15);
    }];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.masksView];
    [UIView animateWithDuration:0.7 animations:^{
        self.maskView.alpha = 1;
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rankArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RankDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankDetailTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.rankArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)removeMask{
    [UIView animateWithDuration:0.7 animations:^{
        self.masksView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.masksView removeFromSuperview];
            self.masksView = nil;
        }
    }];
}
- (void)moveToRankPage:(id)sender{
    RankPageViewController *vc = [[RankPageViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}

- (void)setADArray:(NSArray *)ADArray{
    _ADArray = ADArray;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mainCollectionView reloadData];
    });
    
}

- (void)setListMerchandiseDict:(NSDictionary *)listMerchandiseDict{
    _listMerchandiseDict = [NSDictionary dictionaryWithDictionary: listMerchandiseDict];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mainCollectionView reloadData];
    });
}
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [super hitTest:point withEvent:event];
}

@end
