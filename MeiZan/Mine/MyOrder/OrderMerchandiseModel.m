//
//  OrderMerchandiseModel.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/17.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "OrderMerchandiseModel.h"

@implementation OrderMerchandiseModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"orderNo" : @"id"};
}
@end
