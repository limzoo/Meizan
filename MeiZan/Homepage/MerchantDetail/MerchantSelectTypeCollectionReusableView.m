//
//  MerchantSelectTypeCollectionReusableView.m
//  JingXuan
//
//  Created by sfs on 2017/12/12.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MerchantSelectTypeCollectionReusableView.h"
@interface MerchantSelectTypeCollectionReusableView()
@property (nonatomic, assign) NSUInteger lastIndex;
@property (nonatomic, assign) NSUInteger currentIndex;
@end
@implementation MerchantSelectTypeCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview{
    self.lastIndex = 0;
    self.currentIndex = 0;
    UIButton *button_1 = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:16 title:@"推荐"];
    button_1.tag = 100;
    [button_1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button_1];
    [button_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.mas_equalTo(self);
    }];
    
    UIButton *button_2 = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:16 title:@"上新"];
    button_2.tag = 101;
    [button_2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button_2];
    [button_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.leading.mas_equalTo(button_1.mas_trailing);
        make.width.mas_equalTo(button_1);
    }];
    
    UIButton *button_3 = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:16 title:@"价格"];
    button_3.tag = 102;
    [button_3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button_3];
    [button_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.leading.mas_equalTo(button_2.mas_trailing);
        make.width.mas_equalTo(button_2);
    }];
    
    UIButton *button_4 = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:16 title:@"分类"];
    button_4.tag = 103;
    [button_4 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button_4];
    [button_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.trailing.mas_equalTo(self);
        make.leading.mas_equalTo(button_3.mas_trailing);
        make.width.mas_equalTo(button_3);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR_F5;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

- (void)buttonAction:(UIButton *)sender{
    UIButton *lastButton = [self viewWithTag:self.currentIndex + 100];
    [lastButton setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
    self.lastIndex = self.currentIndex;
    [sender setTitleColor:STYLECOLOR forState:UIControlStateNormal];
    self.currentIndex = sender.tag - 100;
    if ([self.delegate respondsToSelector:@selector(selectedViewDidSelectedIndex:lastIndex:)]) {
        [self.delegate selectedViewDidSelectedIndex:self.currentIndex lastIndex:self.lastIndex];
    }
}
@end
