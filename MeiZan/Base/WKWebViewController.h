//
//  WKWebViewController.h
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseViewController.h"

@interface WKWebViewController : BaseViewController
- (instancetype)initWithUrl:(NSString *)urlStr;
- (instancetype)initWithXlsFileName:(NSString *)fileName;
@end
