//
//  UserCommentModel.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UserCommentModel.h"

@implementation UserCommentModel
- (instancetype)init{
    self = [super init];
    if (self) {
        self.type = -1;
        self.imgArray = [NSMutableArray array];
        self.photoUrl = [NSMutableArray array];
    }
    return self;
}
@end
