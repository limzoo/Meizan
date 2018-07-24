//
//  ChargeRecordModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/31.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChargeRecordModel : NSObject
@property (nonatomic, strong) NSString *PAYMENT_WAY;
@property (nonatomic, strong) NSString *ORDER_REMARKS;
@property (nonatomic, strong) NSString *ORDER_NO;
@property (nonatomic, strong) NSString *LAST_MODIFY_TIME;
@property (nonatomic, strong) NSString *CREATE_TIME;
@property (nonatomic, strong) NSString *ORDER_STATUS;
@property (nonatomic, strong) NSNumber *RECHARGE_AMOUNT;
@property (nonatomic, strong) NSNumber *ACCOUNT_ID;
@property (nonatomic, strong) NSNumber *USER_ID;
@property (nonatomic, strong) NSNumber *ID;
@end
/*"PAYMENT_WAY": "4",支付方式(1-微信2-支付宝4-线下打款)<string>
 "RECHARGE_AMOUNT": 100,充值金额<number>
 "ACCOUNT_ID": 1,账户ID<number>
 "ORDER_REMARKS": "",订单备注<string>
 "USER_ID": 10000001,用户ID<number>
 "ORDER_NO": "1515982818129",订单单号<string>
 "LAST_MODIFY_TIME": "2018-01-17 17:10:34",最后修改时间<string>
 "ID": 1,充值订单id<number>
 "CREATE_TIME": "2018-01-15 10:20:18",创建时间<string>
 "ORDER_STATUS": "6"订单状态(0-待支付1-已支付2-已发货3-已确认4-已评价5-已取消6-待审核7-审核失败)<string>
 */
