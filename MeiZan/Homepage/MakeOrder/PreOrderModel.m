//
//  PreOrderModel.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/17.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "PreOrderModel.h"

@implementation PreOrderModel
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"goodsList":[PreOrderMerchandise class]};
}
@end
