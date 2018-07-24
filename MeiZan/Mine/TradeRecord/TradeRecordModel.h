//
//  TradeRecordModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeRecordModel : NSObject
@property (nonatomic, strong) NSNumber *PRE_BALANCE;
@property (nonatomic, strong) NSNumber *ACCOUNT_ID;
@property (nonatomic, strong) NSNumber *CREDIT_AMOUNT;
@property (nonatomic, strong) NSNumber *USER_ID;
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *DEBIT_AMOUNT;
@property (nonatomic, strong) NSNumber *BALANCE;
@property (nonatomic, strong) NSString *ACCOUNT_TYPE;
@property (nonatomic, strong) NSString *TRANSFER_TYPE;
@property (nonatomic, strong) NSString *ORDER_NO;
@property (nonatomic, strong) NSString *CREATE_TIME;
@property (nonatomic, strong) NSString *NICK_NAME;
@property (nonatomic, strong) NSNumber *PRICE;
@property (nonatomic, strong) NSString *MERCHANT_NAME;
@end
/*"PRE_BALANCE": 0.25,上期余额<number>
 "ACCOUNT_TYPE": "3",账户类型<string>
 "ACCOUNT_ID": 6,账户Id<number>
 "CREDIT_AMOUNT": 1,贷记金额+<number>
 "TRANSFER_TYPE": "4",交易类型<string>
 "USER_ID": 10000002,用户ID<number>
 "ORDER_NO": "1515381618071",订单号<string>
 "ID": 13947,流水ID<number>
 "CREATE_TIME": "2018-01-09 16:47:34",创建时间<string>
 "DEBIT_AMOUNT": 0,借记金额-<number>
 "BALANCE": 1.25本期余额<number>
*/
