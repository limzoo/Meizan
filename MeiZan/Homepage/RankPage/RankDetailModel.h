//
//  RankDetailModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/15.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankDetailModel : NSObject
@property (nonatomic, strong) NSNumber *TRANS_AMOUNT;
@property (nonatomic, strong) NSNumber * USER_ID;
@property (nonatomic, strong) NSNumber * RANK;
@property (nonatomic, strong) NSNumber * ID;
@property (nonatomic, strong) NSString *RANK_NAME;
@property (nonatomic, strong) NSString *USER_TYPE;
@property (nonatomic, strong) NSString *CREATE_TIME;
@property (nonatomic, strong) NSString *NICK_NAME;
@property (nonatomic, strong) NSString *TYPE;
@property (nonatomic, strong) NSString *PHOTO_URL;
@end
/*"TRANS_AMOUNT": 10,交易金额<number>
 "RANK_NAME": "2017年第12月增长额排名",标题(例：第11月交易额排名)<string>
 "USER_TYPE": "1",用户类型(1.商户;2个人;3总代理商;4县代理商)<string>
 "USER_ID": 10001,用户ID<number>
 "RANK": 1,排名<number>
 "ID": 22,排名详情id<number>
 "CREATE_TIME": "2018-01-05 14:48:54",创建时间<string>
 "NICK_NAME": "别改我的",昵称<string>
 "TYPE": "2"排名类型（1.月交易额2月增长额）<string>
*/
