//
//  AddressManageView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "UserAddressModel.h"
@interface AddressManageView : BaseView
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic,copy) void (^backAddressModel)(UserAddressModel *model);
@end
