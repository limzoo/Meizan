//
//  MyAgentModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyAgentModel : NSObject
@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSNumber *experience;
@property (nonatomic, strong) NSNumber *PARENT_ID;
@property (nonatomic, strong) NSString *NICK_NAME;
@property (nonatomic, strong) NSString *REAL_NAME;
@property (nonatomic, strong) NSString *USER_STATUS;
@property (nonatomic, strong) NSString *AUTHENTICATION_STATUS;
@property (nonatomic, strong) NSString *CREATE_TIME;
@property (nonatomic, strong) NSString *LAST_MODIFY_TIME;
@property (nonatomic, strong) NSString *USER_TYPE;
@property (nonatomic, strong) NSString *MERCHANT_NO;
@property (nonatomic, strong) NSString *MOBILE_NO;
@property (nonatomic, strong) NSString *ID_CARD_NO;
@property (nonatomic, strong) NSString *LOGIN_NAME;
@property (nonatomic, strong) NSString *PASSWORD;
@property (nonatomic, strong) NSString *payPassword;
@property (nonatomic, strong) NSString *PHOTO_URL;
@property (nonatomic, strong) NSString *WX_OPEN_ID;
@property (nonatomic, strong) NSString *WX_UNION_ID;
@property (nonatomic, strong) NSString *REGISTER_SRC;
@property (nonatomic, strong) NSString *MERCHANT_ADDRESS;
@property (nonatomic, strong) NSString *MERCHANT_NAME;
@property (nonatomic, strong) MyAgentModel *allParentInfo;
@property (nonatomic, strong) NSMutableArray<MyAgentModel *> *allChildInfoList;
@end
/*"PAY_PASSWORD": "937377F056160FC4B15E0B770C67136A5F03C15205B4D3BF918268FEFA2C6D0A",
 "REGISTER_SRC": "pc",
 "PHOTO_URL": "http://wx.qlogo.cn/mmopen/vi_32/gUL3MX5IOr07fL3VOvC8cEmLL6rPrmJDvgO29I0sMMATvyIpsUIBFgKBAPibb7jW7BS8dhgzr4V6ZITbibsRaGPg/132",
 "USER_STATUS": "ACTIVATED",
 "LAST_MODIFY_TIME": "2018-01-28 03:05:46",
 "NICK_NAME": "邵阳代理商",
 "REAL_NAME": "林宇",
 "PARENT_ID": 16,
 "MOBILE_NO": "18825157133",
 "ID_CARD_NO": "486325199403698745",
 "PASSWORD": "EF51306214D9A6361EE1D5B452E6D2BB70DC7EBB85BF9E02C3D4747FB57D6BEC",
 "MERCHANT_NO": "16800010014",
 "MERCHANT_ADDRESS": "深圳长沙",
 "USER_TYPE": "4",
 "ID": 14,
 "CREATE_TIME": "2018-01-24 17:18:40",
 "LOGIN_NAME": "18825157133",
 "WX_OPEN_ID": "o6MEw0adOM1L8kOiQRNaMDwcEchQ",
 "AUTHENTICATION_STATUS": "1",
 "WX_UNION_ID": "oEs7P1NmAKFjcUWdQ2C_wsrsRUK8"
*/
