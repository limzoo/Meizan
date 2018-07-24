//
//  AddressManageViewController.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseViewController.h"
#import "UserAddressModel.h"
@interface AddressManageViewController : BaseViewController
@property (nonatomic, assign) BOOL shouldSelectBack;
@property (nonatomic,copy) void (^backAddressModel)(UserAddressModel *model);
- (void)deleteAddress:(UserAddressModel *)model;
@end
