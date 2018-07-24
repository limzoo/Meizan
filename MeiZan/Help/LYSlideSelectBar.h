//
//  LYSlideSelectBar.h
//  OilLife
//
//  Created by sfs on 2017/11/30.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYSlideSelectBar;

@protocol LYSlideSelectBarDelegate<NSObject>
@optional
- (void)slideSelectBar:(LYSlideSelectBar *)slideSelectBar didSelectAnotherItemAtIndex:(NSUInteger)index;
- (void)slideSelectBar:(LYSlideSelectBar *)slideSelectBar didSelectSameItemAtIndex:(NSUInteger)index;
@end
@interface LYSlideSelectBar : UIView

@property (nonatomic, weak) id<LYSlideSelectBarDelegate> delegate;
/**
 滑块数量
 */
@property (nonatomic, assign, readonly) NSInteger itemNum;

/**
 滑块颜色
 */
@property (nonatomic, strong, readonly) UIColor *slideViewTinColor;

/**
 项目选中颜色
 */
@property (nonatomic, strong, readonly) UIColor *itemTinColor;
/**
 项目默认颜色
 */
@property (nonatomic, strong, readonly) UIColor *itemDefaultColor;


@property (nonatomic, assign, readonly) NSUInteger currentSelectedIndex;

/**
 是否动画进行中
 */
@property (nonatomic, assign,readonly) BOOL animat;
@property (nonatomic, assign) NSTimeInterval animationDuration;

/**
 标题
 */
@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) NSArray<UIFont *> *titlesFont;

- (instancetype)initWithFrame:(CGRect)frame itemNum:(NSInteger)num slideViewBounds:(CGSize)size;
- (void)setSlideViewTinColor:(UIColor *)slideViewTinColor;
/**
 设置项目颜色

 @param itemTinColor 选中颜色
 @param itemDefaultColor 未选中的颜色
 */
- (void)setItemTinColor:(UIColor *)itemTinColor  defaultColor:(UIColor *)itemDefaultColor;

- (void)setCurrentSelectedIndex:(NSUInteger)currentSelectedIndex;
@end
