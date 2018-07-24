//
//  EmptyCommentTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "EmptyCommentTableViewCell.h"

@implementation EmptyCommentTableViewCell
- (void)createSubview{
    UIImageView *imgView = [[UIImageView alloc] init];
    imgView.image = [UIImage imageNamed:@"无消息"];
    [self.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(118);
        make.height.mas_equalTo(140);
        make.top.mas_equalTo(self.contentView).offset(28);
        make.centerX.mas_equalTo(self.contentView);
    }];
    
    UILabel *label = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x666666) text:@"暂无评论"];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
         make.top.mas_equalTo(imgView.mas_bottom).offset(16);
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
