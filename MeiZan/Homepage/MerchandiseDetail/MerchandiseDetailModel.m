//
//  MerchandiseDetailModel.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/9.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MerchandiseDetailModel.h"
#import "ImageModel.h"
@implementation MerchandiseDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"merchandiseId" : @"id"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"goodsImages":[ImageModel class]};
}
@end
