//
//  SelectPayStyleView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseView.h"
#import "InputPasswordView.h"
@interface SelectPayStyleView : BaseView
@property (nonatomic, strong) NSArray *paymentArray;
@property (nonatomic, strong) InputPasswordView *inputPasswordView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) NSArray *bankArray;

@end
