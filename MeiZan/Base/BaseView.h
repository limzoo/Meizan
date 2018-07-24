//
//  BaseView.h
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView
@property (nonatomic, weak) UIViewController *myViewController;

- (void)configInitial;
- (void)createSubview;
@end
