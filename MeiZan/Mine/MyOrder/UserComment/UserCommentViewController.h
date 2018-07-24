//
//  UserCommentViewController.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseViewController.h"
#import "MyOrderModel.h"
@interface UserCommentViewController : BaseViewController
- (instancetype)initWithModel:(MyOrderModel *)model;
- (void)uploadImg:(UIImage *)image withRow:(NSInteger)row;
- (void)confirmComment:(NSString *)string;
@end
