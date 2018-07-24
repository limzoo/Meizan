//
//  MerchandiseNumSelectButton.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/5.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MerchandiseNumSelectButton.h"
@interface MerchandiseNumSelectButton ()
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *minusButton;
@property (nonatomic, strong) UILabel *numLabel;

@property (nonatomic, assign) NSInteger selectNum;
@end
@implementation MerchandiseNumSelectButton
- (void)configInitial{
    self.selectNum = 0;
}
- (void)createSubview{
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.frame = CGRectMake(0, 0, self.bounds.size.width/3, self.bounds.size.height);
    self.addButton.tag = 10;
    [self.addButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.addButton setTitle:@"+" forState:UIControlStateNormal];
    self.addButton.layer.borderWidth = 1;
    self.addButton.layer.borderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0].CGColor;
    [self addSubview:self.addButton];
    
    self.minusButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.minusButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.minusButton.tag = 11;
    self.minusButton.frame = CGRectMake(self.bounds.size.width*2/3, 0, self.bounds.size.width/3, self.bounds.size.height);
    [self.minusButton setTitle:@"-" forState:UIControlStateNormal];
    self.minusButton.layer.borderWidth = 1;
    self.minusButton.layer.borderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1/1.0].CGColor;
    [self addSubview:self.minusButton];
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/3 + 1, 0, self.bounds.size.width/3 - 2, self.bounds.size.height)];
    self.numLabel.text = @"0";
    self.numLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.numLabel.textColor =  [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0];
    [self addSubview:self.numLabel];
}


- (void)buttonAction:(UIButton *)button{
    switch (button.tag) {
        case 0:{
            self.selectNum ++;
            self.numLabel.text = [NSString stringWithFormat:@"%ld",self.selectNum];
            break;
        }
        case 1:{
            self.selectNum = self.selectNum - 1 < 0 ? 0 : self.selectNum;
            self.numLabel.text = [NSString stringWithFormat:@"%ld",self.selectNum];
            break;
        }
        default:
            break;
    }
    self.numberChange(self.selectNum);
}
@end
