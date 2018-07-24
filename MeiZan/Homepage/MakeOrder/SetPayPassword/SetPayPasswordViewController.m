
//
//  SetPayPasswordViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/26.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "SetPayPasswordViewController.h"
#import "SetPayPasswordView.h"
#import "GLTextField.h"
#import "UIView+category.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//密码位数
static NSInteger const kDotsNumber = 6;

//假密码点点的宽和高  应该是等高等宽的正方形 方便设置为圆
static CGFloat const kDotWith_height = 10;

@interface SetPayPasswordViewController ()<UITextFieldDelegate>

//密码输入文本框
@property (nonatomic,strong) GLTextField *passwordField;
//用来装密码圆点的数组
@property (nonatomic,strong) NSMutableArray *passwordDotsArray;
//默认密码
@property (nonatomic,strong,readonly) NSString *password;
@property (nonatomic, strong) UILabel *const_announceLabel;
@property (nonatomic, assign) BOOL isFirstTime;
@property (nonatomic, strong) NSString *firstTimepassword;
@end

@implementation SetPayPasswordViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        
        SetPayPasswordView *view = [[SetPayPasswordView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}


@end
