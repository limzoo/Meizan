//
//  HomepageViewController.h
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseViewController.h"

@interface HomepageViewController : BaseViewController
- (void)getPageDataMoveToPageWithgoodsName:(NSString *)goodsName categoryName:(NSString *)categoryName minimumPrice:(NSInteger)minimumPrice maximumPrice:(NSInteger)maximumPrice style:(NSString *)style orderBy:(NSString *)orderBy keywords:(NSString *)keywords page:(NSNumber *)page;
- (void)loadRankDetailWithTitle:(NSString *)newsTitle;
@end
