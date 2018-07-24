//
//  ScrollingTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2017/12/25.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "ScrollingTableViewCell.h"
@interface ScrollingTableViewCell()
@property (nonatomic, strong) UILabel *newsLabel;
@end
@implementation ScrollingTableViewCell
- (void)createSubview{
    self.newsLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.newsLabel];
    self.newsLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    [self.newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.bottom.trailing.mas_equalTo(self.contentView);
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

- (void)setNewsTitle:(NSString *)newsTitle{
    _newsTitle = newsTitle;
    self.newsLabel.text = [NSString stringWithFormat:@"·  %@",newsTitle];
}
@end
