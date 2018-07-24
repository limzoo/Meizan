//
//  RatingBar.m
//  MyRatingBar
//
//  Created by Leaf on 14-8-28.
//  Copyright (c) 2014年 Leaf. All rights reserved.
//

#import "RatingBar.h"
#define ZOOM 0.8f
@interface RatingBar()
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,assign) CGFloat starWidth;
@property (nonatomic,assign) CGFloat insetWidth;
@end

@implementation RatingBar

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame unselected_imageName:(NSString *)un_imageName selected_imageName:(NSString *)selected_imageName
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.bottomView = [[UIView alloc] initWithFrame:self.bounds];
        self.topView = [[UIView alloc] initWithFrame:CGRectZero];
        
        [self addSubview:self.bottomView];
        [self addSubview:self.topView];
        
        self.topView.clipsToBounds = YES;
        self.topView.userInteractionEnabled = NO;
        self.bottomView.userInteractionEnabled = NO;
        self.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:tap];
        [self addGestureRecognizer:pan];
        
        //
        CGFloat width = frame.size.height;
        //        CGFloat width = frame.size.width/5.0;
        self.starWidth = width;
        for(int i = 0;i<5;i++){
            //            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width*ZOOM, width*ZOOM)];
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
            self.insetWidth = (frame.size.width - self.starWidth * 5) / 4;
            img.center = CGPointMake((0.5+ i)  * width + i * self.insetWidth, frame.size.height/2);
            //            img.center = CGPointMake(i*width, frame.size.height/2);
            img.image = [UIImage imageNamed:un_imageName];
            [self.bottomView addSubview:img];
            UIImageView *img2 = [[UIImageView alloc] initWithFrame:img.frame];
            img2.center = img.center;
            img2.image = [UIImage imageNamed:selected_imageName];
            [self.topView addSubview:img2];
        }
        self.enable = YES;
        
    }
    return self;
}
-(void)setViewColor:(UIColor *)backgroundColor{
    if(_viewColor!=backgroundColor){
        self.backgroundColor = backgroundColor;
        self.topView.backgroundColor = backgroundColor;
        self.bottomView.backgroundColor = backgroundColor;
    }
}
-(void)setStarNumber:(NSInteger)starNumber{
    if(_starNumber!=starNumber){
        _starNumber = starNumber;
        if (starNumber != 0) {
            self.topView.frame = CGRectMake(0, 0, self.starWidth* starNumber + self.insetWidth * (starNumber - 1), self.bounds.size.height);
        }else{
            self.topView.frame = CGRectMake(0, 0, 0, self.bounds.size.height);
        }
    }
    if([delegate respondsToSelector:@selector(setRating:isHuman:)]){
        [delegate setRating:_starNumber isHuman:NO];
    }
}
-(void)tap:(UITapGestureRecognizer *)gesture{
    if(self.enable){
        CGPoint point = [gesture locationInView:self];
        NSInteger count = (int)(point.x/self.starWidth)+1;
        self.topView.frame = CGRectMake(0, 0, self.starWidth*count, self.bounds.size.height);
        if(count>5){
            _starNumber = 5;
        }else{
            _starNumber = count-1;
        }
    }
    if([delegate respondsToSelector:@selector(setRating:isHuman:)]){
        [delegate setRating:_starNumber isHuman:YES];
    }
}
-(void)pan:(UIPanGestureRecognizer *)gesture{
    if(self.enable){
        CGPoint point = [gesture locationInView:self];
        NSInteger count = (int)(point.x/self.starWidth);
        if(count>=0 && count<=5 && _starNumber!=count){
            self.topView.frame = CGRectMake(0, 0, self.starWidth*(count+1), self.bounds.size.height);
            _starNumber = count;
        }
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
