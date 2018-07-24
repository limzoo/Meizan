//
//  InvoiceModel.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "InvoiceModel.h"

@implementation InvoiceModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"invoiceId" : @"id"};
}
@end
