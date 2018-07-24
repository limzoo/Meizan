//
//  HP_ADCollectionViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/7.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "HP_ADCollectionViewCell.h"
#import "ADModel.h"
@interface HP_ADCollectionViewCell()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end
@implementation HP_ADCollectionViewCell
- (void)createSubview{
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.contentView.bounds delegate:self placeholderImage:nil];
    self.cycleScrollView.autoScrollTimeInterval = 5;
    self.cycleScrollView.showPageControl = YES;
    self.cycleScrollView.hidesForSinglePage = YES;
    self.cycleScrollView.pageControlDotSize = CGSizeMake(8, 8);
    self.cycleScrollView.currentPageDotColor = STYLECOLOR;
    self.cycleScrollView.pageDotColor = [UIColor colorWithRed:180/255.0 green:39/255.0 blue:44/255.0 alpha:23.62/100.0];
    [self.contentView addSubview:self.cycleScrollView];
    
}

- (void)setADArray:(NSArray *)ADArray{
    _ADArray = ADArray;
    NSMutableArray *imgUrlArray = [NSMutableArray array];
    for (ADModel *model in ADArray) {
        [imgUrlArray addObject:model.imageUrl];
    }
    self.cycleScrollView.imageURLStringsGroup = imgUrlArray;
//    self.cycleScrollView relo
}
@end
