//
//  UploadVoucherView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "MyOrderModel.h"
@interface UploadVoucherView : BaseView
@property (nonatomic, strong) MyOrderModel *model;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *bankCard;
@property (nonatomic, strong) UILabel *bankName;
@property (nonatomic, strong) UIImageView *photo;
@end
