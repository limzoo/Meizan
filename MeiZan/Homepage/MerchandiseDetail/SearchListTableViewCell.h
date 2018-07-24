//
//  SearchListTableViewCell.h
//  JingXuan
//
//  Created by sfs on 2017/12/11.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface SearchListTableViewCell : BaseTableViewCell
@property (nonatomic, strong) NSArray<NSString *> *titlesArray;
@property (nonatomic, copy) void (^showSelectView)(void);

@end
