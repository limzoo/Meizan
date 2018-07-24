//
//  UserCommentView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "MyOrderModel.h"
@interface UserCommentView : BaseView
@property (nonatomic, strong) MyOrderModel *model;
- (void)insertPhotoUrlInCommentArray:(NSString *)photoUrl image:(UIImage *)image;
@end
