//
//  ManageInvoiceTableViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/19.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "InvoiceModel.h"
@interface ManageInvoiceTableViewCell : BaseTableViewCell
@property (nonatomic, strong) InvoiceModel *model;
@property (nonatomic, strong) UIImageView *selectImg;
@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *phoneNumber;
@end
