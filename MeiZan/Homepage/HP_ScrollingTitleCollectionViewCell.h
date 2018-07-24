//
//  HP_ScrollingTitleCollectionViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2017/12/25.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseCollectionViewCell.h"
#import "UserMessageModel.h"
@interface HP_ScrollingTitleCollectionViewCell : BaseCollectionViewCell
@property (nonatomic, strong) NSMutableArray *newsArray;
@property (nonatomic, strong) UIButton *arrowIMGV;
@property (nonatomic, weak) UIViewController *myViewcontroller;
- (void)createScrollTimer;
@end
