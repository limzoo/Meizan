//
//  UploadVoucherViewController.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseViewController.h"
#import "MyOrderModel.h"
@interface UploadVoucherViewController : BaseViewController
- (instancetype)initWithModel:(MyOrderModel *)model;
- (void)uploadVoucherImg:(UIImage *)img;
- (void)uploadVoucher;
@end
