//
//  MessageDetailView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/21.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MessageDetailView.h"
#import "MessageDetailTableViewCell.h"
#import <WebKit/WebKit.h>
@interface MessageDetailView()
@property (nonatomic, strong) UIWebView *webView;
@end
@implementation MessageDetailView
- (void)createSubview{
    self.webView = [[UIWebView alloc] init];
    [self addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.bottom.mas_equalTo(self);
    }];
}

- (void)setModel:(UserMessageModel *)model{
    _model = model;
    [self.webView loadHTMLString:model.MESSAGE_CONTENT baseURL:nil];
}
@end
