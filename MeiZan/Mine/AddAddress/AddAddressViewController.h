//
//  AddAddressViewController.h
//  JingXuan
//
//  Created by sfs on 2017/12/15.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseViewController.h"
#import "UserAddressModel.h"
@interface AddAddressViewController : BaseViewController
@property (nonatomic, strong) UserAddressModel *model;
- (void)addAddressWithDataDic:(NSDictionary *)dataDic;
@end
