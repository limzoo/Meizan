//
//  MessageDetailTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/21.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MessageDetailTableViewCell.h"
#import <WebKit/WebKit.h>
@interface MessageDetailTableViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) WKWebView *webView;
@end
@implementation MessageDetailTableViewCell
- (void)createSubview{
    self.titleLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:18] color:TITLECOLOR text:@""];
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.centerX.mas_equalTo(self);
    }];
    
    self.timeLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x999999) text:@""];
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    self.webView = [[WKWebView alloc] init];
    [self addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self);
        make.top.mas_equalTo(lineView.mas_bottom);
    }];
}

- (void)setModel:(UserMessageModel *)model{
    _model = model;
    [self.webView loadHTMLString:model.MESSAGE_CONTENT baseURL:nil];
    self.timeLabel.text = model.CREATE_TIME;
    self.titleLabel.text = model.MESSAGE_TITLE;
}
@end
