//
//  WXLoginView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "WXLoginView.h"
#import "WXLoginBindViewController.h"
#import "WXLoginViewController.h"
@interface WXLoginView()

@end
@implementation WXLoginView
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    self.iconIMGV = [[UIImageView alloc] init];
    [self addSubview:self.iconIMGV];
    [self.iconIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(68);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(40);
    }];
    
    self.nameLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@"亲爱的微信用户:"];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.iconIMGV.mas_bottom).offset(26);
    }];
    
    UILabel *const_annouLable = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"为了给您更好的服务，请关联一个美赞账户"];
    [self addSubview:const_annouLable];
    [const_annouLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(8);
    }];
    
    UILabel *const_askLable = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"还没有美赞账号？"];
    [self addSubview:const_askLable];
    [const_askLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(const_annouLable.mas_bottom).offset(18);
    }];
    
    UIButton *registerButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4 fontSize:16 title:@"立即注册"];
    [self addSubview:registerButton];
    [registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(const_askLable.mas_bottom).offset(18);
    }];
    
    UILabel *const_askAgainLable = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"已有美赞账号？"];
    [self addSubview:const_askAgainLable];
    [const_askAgainLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLabel);
        make.top.mas_equalTo(registerButton.mas_bottom).offset(46);
    }];
    
    UIButton *bindButton = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:4 fontSize:16 title:@"立即关联"];
    [bindButton addTarget:self action:@selector(moveToBindPage) forControlEvents:UIControlEventTouchUpInside];
    bindButton.layer.borderColor = STYLECOLOR.CGColor;
    bindButton.layer.borderWidth = 1;
    [self addSubview:bindButton];
    [bindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(const_askAgainLable.mas_bottom).offset(18);
    }];
}

- (void)moveToBindPage{
    [((WXLoginViewController *)self.myViewController) moveToBindPage];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
