//
//  PaySignHandler.h
//  OilLife
//
//  Created by sfs on 16/10/10.
//  Copyright © 2016年 sfs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaySignHandler : NSObject


//创建package签名
-(NSString*) createMd5Sign:(NSMutableDictionary*)dict;
//获取package带参数的签名包
-(NSString *)genPackage:(NSMutableDictionary*)packageParams;


@end
