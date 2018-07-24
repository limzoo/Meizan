//
//  MessageDetailViewController.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/21.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseViewController.h"
#import "UserMessageModel.h"
@interface MessageDetailViewController : BaseViewController
@property (nonatomic ,assign) CGFloat cellHeight;
- (instancetype)initWithModel:(UserMessageModel *)model;
@end
