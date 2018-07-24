//
//  MakeOrderView.h
//  JingXuan
//
//  Created by sfs on 2017/12/14.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "MerchandiseDetailModel.h"
#import "MerchandiseSelectResultModel.h"
#import "PreOrderModel.h"
#import "InvoiceModel.h"
#import "InputPasswordView.h"
#import "BankModel.h"
@interface MakeOrderView : BaseView
@property (nonatomic, strong) UIView *maskView;//遮罩层
@property (nonatomic, strong) NSMutableArray *userAddressArray;
@property (nonatomic, strong) UserAddressModel *currentAddressModel;
@property (nonatomic, strong) NSMutableArray<MerchandiseSelectResultModel *> *merchandiseArray;
@property (nonatomic, strong) PreOrderModel *model;

@property (nonatomic, strong) NSArray *bankArray;
@property (nonatomic, strong) NSArray *paymentStyleArray;
@property (nonatomic, strong) NSArray *invoiceArray;
@property (nonatomic, strong) InvoiceModel *currentInvoiceModel;
@property (nonatomic, strong) InputPasswordView *inputPasswordView;
@property (nonatomic, strong) NSString *deliverTime;
@property (nonatomic, strong) BankModel *selectBankModel;
@end
