//
//  BlockDetailViewController.h
//  MeiZan
//
//  Created by 林宇 on 2018/2/9.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "BaseViewController.h"

@interface BlockDetailViewController : BaseViewController
- (instancetype)initWithDataArray:(NSArray *)dataArray type:(NSString *)style categoryName:(NSString *)categoryName keyWords:(NSString *)keyWords;

- (void)getPageDataWithKeywords:(NSString *)keywords withPage:(NSInteger)page;
@end