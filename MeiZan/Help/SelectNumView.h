//
//  SelectNumView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/21.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"

@interface SelectNumView : BaseView
@property (nonatomic,copy) void (^changeSelectNum)(NSUInteger num);
@property (nonatomic, strong) UITextField *numTextField;
@end
