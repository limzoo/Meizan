//
//  ImaginaryLine.m
//  OilLife
//
//  Created by sfs on 2017/11/1.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "ImaginaryLine.h"
@interface ImaginaryLine()
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint finalPoint;
@end
@implementation ImaginaryLine
- (instancetype)initImaginaryStraightLineFrom:(CGPoint)startPoint to:(CGPoint)finalPoint{
    self = [super init];
    if (self) {
        _startPoint = startPoint;
        _finalPoint = finalPoint;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    //设置虚线颜色
    CGContextSetStrokeColorWithColor(currentContext, [UIColor blackColor].CGColor);
    //设置虚线宽度
    CGContextSetLineWidth(currentContext, 1);
    //设置虚线绘制起点
    CGContextMoveToPoint(currentContext, 0, 0);
    //设置虚线绘制终点
    CGContextAddLineToPoint(currentContext, self.frame.origin.x + self.frame.size.width, 0);
    //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
    CGFloat arr[] = {3,1};
    //下面最后一个参数“2”代表排列的个数。
    CGContextSetLineDash(currentContext, 0, arr, 2);
    CGContextDrawPath(currentContext, kCGPathStroke);
}


@end
