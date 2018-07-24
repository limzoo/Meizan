//
//  AllComment.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "MerchandiseUserComment.h"
@interface AllComment : BaseView
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIButton *allButton;
@property (nonatomic, strong) UIButton *haveButton;
@property (nonatomic, strong) UIButton *noneButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *rateLabel;
@end
