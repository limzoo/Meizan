//
//  BaseWebView.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/4.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface BaseWebView : WKWebView
@property (nonatomic, strong) UIProgressView *progressView;
@end
