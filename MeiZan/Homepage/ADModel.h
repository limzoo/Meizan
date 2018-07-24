//
//  ADModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/21.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADModel : NSObject
@property (nonatomic, strong) NSNumber *ADId;
@property (nonatomic, strong) NSNumber *adPositionId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, strong) NSString *modifyTime;
@property (nonatomic, strong) NSString *createTime;
@end
