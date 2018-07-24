//
//  NextStepTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/12.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "NextStepTableViewCell.h"

@implementation NextStepTableViewCell
- (void)createSubview{
    self.nextStepButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4.0f fontSize:16 title:@"提交"];
    [self.contentView addSubview:self.nextStepButton];
    [self.nextStepButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.centerX.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
