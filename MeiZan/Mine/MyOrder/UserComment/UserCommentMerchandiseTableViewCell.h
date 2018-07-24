//
//  UserCommentMerchandiseTableViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "OrderMerchandiseModel.h"
#import "UserCommentModel.h"
@interface UserCommentMerchandiseTableViewCell : BaseTableViewCell
@property (nonatomic, strong) OrderMerchandiseModel *model;
@property (nonatomic, strong) UserCommentModel *commentModel;
@property (nonatomic, strong) UIImageView *merchandiseIMGV;
@property (nonatomic, strong) FSTextView *textView;
@property (nonatomic, strong) UIImageView *uploadPicIMGV_1;
@property (nonatomic, strong) UIImageView *uploadPicIMGV_2;
@property (nonatomic, strong) UIImageView *uploadPicIMGV_3;
@property (nonatomic,copy) void (^buttonSelectAction)(NSInteger type);
@end
