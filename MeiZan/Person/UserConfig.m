//
//  UserConfig.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/10.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UserConfig.h"

@implementation UserConfig
static UserConfig *_instance;
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    //    @synchronized (self) {
    //        // 为了防止多线程同时访问对象，造成多次分配内存空间，所以要加上线程锁
    //        if (_instance == nil) {
    //            _instance = [super allocWithZone:zone];
    //        }
    //        return _instance;
    //    }
    // 也可以使用一次性代码
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    return _instance;
}
// 为了使实例易于外界访问 我们一般提供一个类方法
// 类方法命名规范 share类名|default类名|类名
+(instancetype)shareInstance
{
    //return _instance;
    // 最好用self 用Tools他的子类调用时会出现错误
    return [[self alloc]init];
}
// 为了严谨，也要重写copyWithZone 和 mutableCopyWithZone
-(id)copyWithZone:(NSZone *)zone
{
    return _instance;
}
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userInfo forKey:@"userInfo"];
    [aCoder encodeObject:self.merchantInfo forKey:@"merchantInfo"];
     [aCoder encodeObject:self.levelName forKey:@"levelName"];
     [aCoder encodeObject:self.isPayPassword forKey:@"isPayPassword"];
}

- (id)initWithCoder:(NSCoder*)decoder{
    if (self= [super init])
    {
        if (decoder == nil)
        {
            return self;
        }
        self.userInfo = [decoder decodeObjectForKey:@"userInfo"];
        self.merchantInfo = [decoder decodeObjectForKey:@"merchantInfo"];
        self.levelName = [decoder decodeObjectForKey:@"levelName"];
         self.isPayPassword = [decoder decodeObjectForKey:@"isPayPassword"];
    }
    return self;
}

@end
