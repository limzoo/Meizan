//
//  AddressManageTableViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "UserAddressModel.h"
@interface AddressManageTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UserAddressModel *model;
@property (nonatomic, strong) UIButton *editButton;
@end
