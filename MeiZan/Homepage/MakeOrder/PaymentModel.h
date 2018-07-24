//
//  PaymentModel.h
//  MeiZan
//
//  Created by 林宇 on 2018/3/1.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentModel : NSObject
@property (nonatomic, strong) NSNumber *paymentId;
@property (nonatomic, strong) NSNumber *channelFee;
@property (nonatomic, strong) NSString *publicKeyPath;
@property (nonatomic, strong) NSString *transUrl;
@property (nonatomic, strong) NSString *acqCnname;
@property (nonatomic, strong) NSString *merchantKey;
@property (nonatomic, strong) NSString *acqName;
@property (nonatomic, strong) NSString *privateKeyPfxPath;
@property (nonatomic, strong) NSString *transType;
@property (nonatomic, strong) NSString *classPath;
@property (nonatomic, strong) NSString *merchantNo;
@property (nonatomic, strong) NSString *openStatus;
@property (nonatomic, strong) NSString *classMethod;
@end
