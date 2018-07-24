//
//  InvoiceModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvoiceModel : NSObject
@property (nonatomic, strong) NSString *invoiceName;
@property (nonatomic, strong) NSString *invoiceType;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *identifyNumber;
@property (nonatomic, strong) NSString *isDefault;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSNumber *invoiceId;
@property (nonatomic, strong) NSNumber *userId;

@end
/*"id": 1,发票id<number>
 "userId": 10000001,用户id<number>
 "invoiceName": "融和金通",发票抬头(公司名称或者个人姓名)<string>
 "invoiceType": "2",发票类型1个人2公司<string>
 "content": "日用品",发票内容<string>
 "identifyNumber": "62623452345234",纳税人识别号或统一社会信用代码<string>
 "isDefault": "1",是否默认(0-否;1-是)<string>
 "createTime": "2017-12-27 15:04:57"创建时间<string>
*/
