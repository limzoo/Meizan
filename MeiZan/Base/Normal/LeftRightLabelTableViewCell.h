//
//  LeftRightLabelTableViewCell.h
//  JingXuan
//
//  Created by sfs on 2017/12/14.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface LeftRightLabelTableViewCell : BaseTableViewCell
@property (nonatomic, assign) BOOL hasArrow;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@end
