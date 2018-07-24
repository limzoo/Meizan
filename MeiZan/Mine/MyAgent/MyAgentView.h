//
//  MyAgentView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "MyAgentModel.h"
@interface MyAgentView : BaseView
@property (nonatomic, strong) NSArray *childInfoArray;
@property (nonatomic, strong) MyAgentModel *parentInfo;
@property (nonatomic, strong) MyAgentModel *userInfo;
@end
