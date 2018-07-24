//
//  BankModel.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/17.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BankModel.h"

@implementation BankModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"bankCardId" : @"id"};
}
@end
