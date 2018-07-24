//
//  UserCommentTotalTableViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "RatingBar.h"
@interface UserCommentTotalTableViewCell : BaseTableViewCell
@property (nonatomic, strong) RatingBar *rateBar_1;
@property (nonatomic, strong) RatingBar *rateBar_2;
@property (nonatomic, strong) RatingBar *rateBar_3;
@property (nonatomic, assign) BOOL isAnony;
@property (nonatomic, strong) UIView *anonymityView;
@property (nonatomic, strong) UIButton *confirmButton;
@end
