//
//  UserInfo.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"userId":@"id"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:[NSNumber numberWithLong:self.userId] forKey:@"userId"];
    [aCoder encodeObject:self.nickName forKey:@"nickName"];
    [aCoder encodeObject:self.realName forKey:@"realName"];
    [aCoder encodeObject:self.userStatus forKey:@"userStatus"];
    [aCoder encodeObject:self.authenticationStatus forKey:@"authenticationStatus"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.lastModifyTime forKey:@"lastModifyTime"];
    [aCoder encodeObject:self.userType forKey:@"userType"];
    [aCoder encodeObject:self.mobileNo forKey:@"mobileNo"];
    [aCoder encodeObject:self.merchantNo forKey:@"merchantNo"];
    [aCoder encodeObject:self.idCardNo forKey:@"idCardNo"];
    [aCoder encodeObject:self.password forKey:@"password"];
    [aCoder encodeObject:self.payPassword forKey:@"payPassword"];
    [aCoder encodeObject:self.photoUrl forKey:@"photoUrl"];
    [aCoder encodeObject:self.registerSrc forKey:@"registerSrc"];
    [aCoder encodeObject:[NSNumber numberWithLong:self.experience] forKey:@"experience"];
    [aCoder encodeObject:self.wxOpenId forKey:@"wxOpenId"];
    [aCoder encodeObject:self.wxUnionId forKey:@"wxUnionId"];
    [aCoder encodeObject:self.balance forKey:@"balance"];
    [aCoder encodeObject:self.integral forKey:@"integral"];
    [aCoder encodeObject:self.brokerage forKey:@"brokerage"];
}

- (id)initWithCoder:(NSCoder*)decoder{
    if (self= [super init])
    {
        if (decoder == nil)
        {
            return self;
        }
        self.userId = ((NSNumber *)[decoder decodeObjectForKey:@"userId"]).longValue;
        self.nickName = [decoder decodeObjectForKey:@"nickName"];
        self.realName = [decoder decodeObjectForKey:@"realName"];
        self.userStatus = [decoder decodeObjectForKey:@"userStatus"];
        self.authenticationStatus = [decoder decodeObjectForKey:@"authenticationStatus"];
        self.createTime = [decoder decodeObjectForKey:@"createTime"];
        self.lastModifyTime = [decoder decodeObjectForKey:@"lastModifyTime"];
        self.userType = [decoder decodeObjectForKey:@"userType"];
        self.mobileNo = [decoder decodeObjectForKey:@"mobileNo"];
        self.merchantNo = [decoder decodeObjectForKey:@"merchantNo"];
        self.idCardNo = [decoder decodeObjectForKey:@"idCardNo"];
        self.password = [decoder decodeObjectForKey:@"password"];
        self.photoUrl = [decoder decodeObjectForKey:@"photoUrl"];
        self.registerSrc = [decoder decodeObjectForKey:@"registerSrc"];
        self.experience = ((NSNumber *)[decoder decodeObjectForKey:@"experience"]).longValue;;
        self.wxOpenId = [decoder decodeObjectForKey:@"wxOpenId"];
        self.wxUnionId = [decoder decodeObjectForKey:@"wxUnionId"];
        self.balance = [decoder decodeObjectForKey:@"balance"];
        self.integral = [decoder decodeObjectForKey:@"integral"];
         self.brokerage = [decoder decodeObjectForKey:@"brokerage"];
    }
    return self;
}
@end
