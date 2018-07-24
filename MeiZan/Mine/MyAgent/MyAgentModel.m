//
//  MyAgentModel.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyAgentModel.h"

@implementation MyAgentModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"allChildInfoList" : [MyAgentModel class]};
}
@end
