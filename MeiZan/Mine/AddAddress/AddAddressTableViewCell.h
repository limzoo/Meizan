//
//  AddAddressTableViewCell.h
//  JingXuan
//
//  Created by sfs on 2017/12/15.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface AddAddressTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UIImageView *iconIMGV;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UIImageView *arrowImgView;
@property (nonatomic, assign) BOOL hasArrow;
@end
