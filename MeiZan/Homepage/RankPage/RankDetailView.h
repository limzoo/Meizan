//
//  RankDetailView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/15.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"

@interface RankDetailView : BaseView
@property (nonatomic, strong) NSMutableArray *rankArray;
@property (nonatomic, assign) long userAmount;
@property (nonatomic, assign) long userRank;
@property (nonatomic, strong) UILabel *titleLabel;
@end
