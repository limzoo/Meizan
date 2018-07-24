//
//  ManageInvoiceView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "InvoiceModel.h"
@interface ManageInvoiceView : BaseView
@property (nonatomic,copy) void (^selectInvoice)(InvoiceModel *model);
@property (nonatomic, strong) NSMutableArray *invoiceArray;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *phoneNumber;
@end
