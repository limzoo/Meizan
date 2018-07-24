//
//  ManageInvoiceViewController.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseViewController.h"
#import "InvoiceModel.h"
@interface ManageInvoiceViewController : BaseViewController
@property (nonatomic, strong) InvoiceModel *currentModel;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic,copy) void (^selectInvoice)(InvoiceModel *model);
- (instancetype)initWithModel:(InvoiceModel *)model money:(NSString *)money phoneNum:(NSString *)phoneNumber;
- (void)deleteInvoice:(NSString *)invoiceId;
@end
