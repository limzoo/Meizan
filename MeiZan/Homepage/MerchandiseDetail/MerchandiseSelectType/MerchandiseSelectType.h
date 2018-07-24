//
//  MerchandiseSelectType.h
//  JingXuan
//
//  Created by sfs on 2017/12/13.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "MerchandiseDetailModel.h"
#import "MerchandiseSelectResultModel.h"
@interface MerchandiseSelectType : BaseView
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MerchandiseDetailModel *model;//外部传来的model
@property (nonatomic, strong) MerchandiseSelectResultModel *selectModel;//选中规格model
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *shopCartId;
@end
