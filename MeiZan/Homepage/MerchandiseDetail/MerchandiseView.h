//
//  MerchandiseView.h
//  JingXuan
//
//  Created by sfs on 2017/12/11.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "MerchandiseHeaderTableViewCell.h"
#import "SearchListTableViewCell.h"
#import "UserReplyTableViewCell.h"
#import "MerchandiseSelectTypeViewController.h"
#import "MakeOrderViewController.h"
#import "MerchandiseDetailModel.h"
#import "MerchandiseUserComment.h"
#import "BaseWebView.h"
@interface MerchandiseView : BaseView
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UIView *masksView;
@property (nonatomic, strong) MerchandiseSelectTypeViewController *selectVC;
@property (nonatomic, strong) UIView *selectTypeView;
@property (nonatomic, strong) UILabel *priceLabel;


@property (nonatomic, strong) BaseWebView *myWebView;
@property (nonatomic, assign) NSUInteger currentSegmentIndex;

@property (nonatomic, strong) MerchandiseDetailModel *model;
@property (nonatomic, strong) NSMutableArray *typeModelArray;
@property (nonatomic, strong) MerchandiseUserComment *comment;

@property (nonatomic, strong) UILabel *shopCartNumLabel;
@property (nonatomic, strong) NSArray *goodsImagesArray;
@end
