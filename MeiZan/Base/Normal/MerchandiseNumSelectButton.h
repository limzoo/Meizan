//
//  MerchandiseNumSelectButton.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/5.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchandiseNumSelectButton : BaseView
@property (nonatomic,copy) void (^numberChange)(NSInteger selectNum);
@end
