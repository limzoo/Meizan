//
//  MerchandiseViewController.h
//  JingXuan
//
//  Created by sfs on 2017/12/10.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseViewController.h"

@interface MerchandiseViewController : BaseViewController
- (instancetype)initWithMerchandiseID:(NSString *)merchandiseID;
- (void)getShopCartNum;
@end
