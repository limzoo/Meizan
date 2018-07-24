//
//  MerchantInfo.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MerchantInfo.h"

@implementation MerchantInfo
+ (NSDictionary *)modelCustomPropertyMapper{
    return @{@"merchantId":@"id"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:[NSNumber numberWithLong:self.merchantId] forKey:@"merchantId"];
    [aCoder encodeObject:self.merchantNo forKey:@"merchantNo"];
    [aCoder encodeObject:self.merchantName forKey:@"merchantName"];
    [aCoder encodeObject:self.merchantStatus forKey:@"merchantStatus"];
    [aCoder encodeObject:self.authenticationStatus forKey:@"authenticationStatus"];
    [aCoder encodeObject:self.createTime forKey:@"createTime"];
    [aCoder encodeObject:self.lastModifyTime forKey:@"lastModifyTime"];
    [aCoder encodeObject:self.merchantAddress forKey:@"merchantAddress"];
    [aCoder encodeObject:self.imageUrl forKey:@"imageUrl"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
}

- (id)initWithCoder:(NSCoder*)decoder{
    if (self= [super init])
    {
        if (decoder == nil)
        {
            return self;
        }
        self.merchantId = ((NSNumber *)[decoder decodeObjectForKey:@"userInfo"]).longValue;
        self.merchantNo = [decoder decodeObjectForKey:@"merchantNo"];
        self.merchantName = [decoder decodeObjectForKey:@"merchantName"];
        self.merchantStatus = [decoder decodeObjectForKey:@"merchantStatus"];
        self.authenticationStatus = [decoder decodeObjectForKey:@"authenticationStatus"];
        self.createTime = [decoder decodeObjectForKey:@"createTime"];
        self.lastModifyTime = [decoder decodeObjectForKey:@"lastModifyTime"];
        self.merchantAddress = [decoder decodeObjectForKey:@"merchantAddress"];
        self.imageUrl = [decoder decodeObjectForKey:@"imageUrl"];
        self.desc = [decoder decodeObjectForKey:@"desc"];
    }
    return self;
}
@end
