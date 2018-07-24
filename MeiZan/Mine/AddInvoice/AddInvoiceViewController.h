//
//  AddInvoiceViewController.h
//  JingXuan
//
//  Created by sfs on 2017/12/18.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseViewController.h"

@interface AddInvoiceViewController : BaseViewController
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *phoneNumber;
- (instancetype)initWithMoney:(NSString *)money phoneNum:(NSString *)phoneNumber;
- (void)uploadInvoiceWithId:(NSString *)invoiceId invoiceName:(NSString *)invoiceName invoiceType:(NSString *)invoiceType identifyNumber:(NSString *)identifyNumber isDefault:(NSString *)isDefault content:(NSString *)content;
@end
