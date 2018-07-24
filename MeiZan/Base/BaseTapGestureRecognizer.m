//
//  BaseTapGestureRecognizer.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseTapGestureRecognizer.h"

@implementation BaseTapGestureRecognizer
- (NSMutableDictionary *)userInfoDic{
    if (!_userInfoDic) {
        _userInfoDic = [NSMutableDictionary dictionary];
    }
    return _userInfoDic;
}
@end
