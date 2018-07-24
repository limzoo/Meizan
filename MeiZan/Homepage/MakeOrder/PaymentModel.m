//
//  PaymentModel.m
//  MeiZan
//
//  Created by 林宇 on 2018/3/1.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "PaymentModel.h"

@implementation PaymentModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"paymentId" : @"id"};
}
@end
