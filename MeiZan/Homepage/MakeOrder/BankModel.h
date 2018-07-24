//
//  BankModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/17.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankModel : NSObject
@property (nonatomic, strong) NSNumber *bankCardId;
@property (nonatomic, strong) NSString *collectName;
@property (nonatomic, strong) NSString *collectBankNo;
@property (nonatomic, strong) NSString *collectBankName;
@property (nonatomic, strong) NSString *collectBankBranchName;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *createTime;
@end

/*"id": 1,<number>
 "collectName": "测试人",收款人姓名<string>
 "collectBankNo": "8965478965412365478",收款人卡号<string>
 "collectBankName": "中国银行",收款人银行名称<string>
 "collectBankBranchName": "宝安新安支行",收款人支行名称<string>
 "status": "1",状态<string>
 "createTime": "2017-12-26 15:47:13"创建时间<string>
*/
