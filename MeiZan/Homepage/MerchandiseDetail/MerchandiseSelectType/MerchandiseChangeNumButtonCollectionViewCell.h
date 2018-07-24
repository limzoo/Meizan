//
//  MerchandiseChangeNumButtonCollectionViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/16.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@interface MerchandiseChangeNumButtonCollectionViewCell : BaseCollectionViewCell
@property (nonatomic,copy) void (^changeSelectNum)(NSUInteger num);
@property (nonatomic, assign) NSInteger initialNum;
@end
