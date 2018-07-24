//
//  BankSelectView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/17.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"

@interface BankSelectView : BaseView
@property (nonatomic, strong) NSArray *bankArray;
@property (nonatomic,copy) void (^ensureButtonAction)(NSInteger index);
@property (nonatomic,copy) void (^cancelButtonAction)(void);
@end
