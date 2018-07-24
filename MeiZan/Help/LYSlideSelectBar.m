//
//  LYSlideSelectBar.m
//  OilLife
//
//  Created by sfs on 2017/11/30.
//  Copyright © 2017年 rhjt. All rights reserved.
//
//自定义第一版,第二版可能需要自定义控件的了
#import "LYSlideSelectBar.h"
@interface LYSlideSelectBar()
@property (nonatomic, strong) UIView *slideView;
@end
@implementation LYSlideSelectBar
- (instancetype)initWithFrame:(CGRect)frame itemNum:(NSInteger)num slideViewBounds:(CGSize)size{
    self = [super initWithFrame:frame];
    if (self) {
        [self configInitial];
        [self createSubviewWithNum:num];
        [self createSlideView:size];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
      
    }
    return self;
}
- (void)configInitial{
    _animationDuration = 0.4;
    //默认初始选中的item为0;
    _currentSelectedIndex = 0;
    _itemDefaultColor = [UIColor blackColor];
    _itemTinColor = [UIColor grayColor];
    _slideViewTinColor = [UIColor whiteColor];
    _animat = NO;
    self.backgroundColor = [UIColor whiteColor];
}
- (void)createSubviewWithNum:(NSInteger)num{
    _itemNum = num;
    for (int i = 0; i < num;  i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * self.bounds.size.width / num, 0, self.bounds.size.width / num, self.bounds.size.height);
        button.tag =  i + 100;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}

- (void)createSlideView:(CGSize)size{
    CGRect firstButtonFrame = ((UIButton *)[self viewWithTag:100]).frame;
    CGFloat x = firstButtonFrame.size.width/2 - size.width/2;
    CGFloat y = firstButtonFrame.size.height - size.height;
    self.slideView = [[UIView alloc] initWithFrame:CGRectMake(x, y, size.width, size.height)];
    [self addSubview:self.slideView];
    [self bringSubviewToFront:self.slideView];
}
//在这一层分发处理,还需要处理选中动画进行中的处理问题,可能会冲突
- (void)buttonAction:(UIButton *)sender{
    if(sender.tag - 100 != self.currentSelectedIndex){
        [self didSelectAnotherItem:sender];
    }else{
        [self didSelectSameItem:sender];
    }
}

- (void)didSelectAnotherItem:(UIButton *)sender{
    [self slideViewAction:sender.tag - 100];
    if ([self.delegate respondsToSelector:@selector(slideSelectBar:didSelectAnotherItemAtIndex:)]) {
        [self.delegate slideSelectBar:self didSelectAnotherItemAtIndex:sender.tag - 100];
    }
}

- (void)didSelectSameItem:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(slideSelectBar:didSelectSameItemAtIndex:)]) {
        [self.delegate slideSelectBar:self didSelectSameItemAtIndex:sender.tag - 100];
    }
}
- (void)slideViewAction:(NSUInteger)selectedIndex{
    UIButton *targetButton = [self viewWithTag:selectedIndex + 100];
    UIButton *oldButton = [self viewWithTag:_currentSelectedIndex + 100];
    [UIView animateWithDuration:self.animationDuration animations:^{
        _animat = YES;
        [oldButton setTitleColor:_itemDefaultColor forState:UIControlStateNormal];
        [targetButton setTitleColor:_itemTinColor forState:UIControlStateNormal];
        _currentSelectedIndex = selectedIndex;
        self.slideView.center = CGPointMake(targetButton.center.x, self.slideView.center.y);
    } completion:^(BOOL finished) {
        if (finished) {
            if ([self.delegate respondsToSelector:@selector(slideSelectBar: didSelectAnotherItemAtIndex:)]) {
                [self.delegate slideSelectBar:self didSelectAnotherItemAtIndex:selectedIndex];
            }
        }
    }];
}

- (void)setSlideViewTinColor:(UIColor *)slideViewTinColor{
    _slideViewTinColor = slideViewTinColor;
    self.slideView.backgroundColor = slideViewTinColor;
}

- (void)setItemTinColor:(UIColor *)itemTinColor defaultColor:(UIColor *)itemDefaultColor{
    _itemTinColor = itemTinColor;
    _itemDefaultColor = itemDefaultColor;
    for (int i = 0; i < self.itemNum; i ++) {
        UIButton *button = [self viewWithTag:i + 100];
        //tag和index对比
        if (button.tag == self.currentSelectedIndex + 100) {
            [button setTitleColor:_itemTinColor forState:UIControlStateNormal];
            continue;
        }
        [button setTitleColor:itemDefaultColor forState:UIControlStateNormal];
    }
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    for (int i = 0; i < self.itemNum; i ++) {
        UIButton *button = [self viewWithTag:i + 100];
        [button setTitle:titles[i] forState:UIControlStateNormal];
    }
}

- (void)setTitlesFont:(NSArray<UIFont *> *)titlesFont{
   for (int i = 0; i < self.itemNum; i ++) {
        UIButton *button = [self viewWithTag:i + 100];
       button.titleLabel.font = titlesFont[i];
    }
}

- (void)setCurrentSelectedIndex:(NSUInteger)currentSelectedIndex{
    UIButton *targetButton = [self viewWithTag:currentSelectedIndex + 100];
    UIButton *oldButton = [self viewWithTag:_currentSelectedIndex + 100];
    [UIView animateWithDuration:self.animationDuration animations:^{
        _animat = YES;
        [oldButton setTitleColor:_itemDefaultColor forState:UIControlStateNormal];
        [targetButton setTitleColor:_itemTinColor forState:UIControlStateNormal];
        _currentSelectedIndex = currentSelectedIndex;
        self.slideView.center = CGPointMake(targetButton.center.x, self.slideView.center.y);
    } completion:^(BOOL finished) {
        if (finished) {

        }
    }];
}
@end
