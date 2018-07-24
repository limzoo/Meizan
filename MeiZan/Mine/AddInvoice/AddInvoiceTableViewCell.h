//
//  AddInvoiceTableViewCell.h
//  JingXuan
//
//  Created by sfs on 2017/12/18.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface AddInvoiceTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UIButton *titleTypeButton_person;
@property (nonatomic, strong) UIButton *titleTypeButton_company;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UILabel *const_titleMsg;
@property (nonatomic, strong) UITextField *companyName;
@property (nonatomic, strong) UITextField *companyContent;
@property (nonatomic, strong) UITextField *invoiceContent;
@property (nonatomic, strong) UITextField *USCCNumberTextField;
@property (nonatomic, strong) UILabel *invoicePhoneNumber;
@property (nonatomic, strong) UILabel *invoiceMoney;
@end
