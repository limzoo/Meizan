//
//  ChargeView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "BankModel.h"
@interface ChargeView : BaseView
@property (nonatomic, strong) BankModel *currentBankModel;
@property (nonatomic, strong) NSArray *bankArray;
@property (nonatomic, strong) NSMutableArray *paymentStyleArray;
@end
