//
//  TypeTitleTableViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/7.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "TypeTitleTableViewCell.h"
@interface TypeTitleTableViewCell()
/**
 选中时的标记
 */
@property (nonatomic, strong) UIView *lineView;
@end
@implementation TypeTitleTableViewCell
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"title"];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];

    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(3));
        make.height.mas_equalTo(20);
        make.leading.centerY.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.top.mas_equalTo(self);
        make.leading.mas_equalTo(self.lineView.mas_trailing);
    }];
}

- (void)setDidSelected:(BOOL)didSelected{
    _didSelected = didSelected;
    if (didSelected == YES) {
        self.titleLabel.textColor = STYLECOLOR;
        self.lineView.backgroundColor = STYLECOLOR;
    }else{
        self.titleLabel.textColor = TEXTCOLOR;
        self.lineView.backgroundColor = COLOR_RGB16(0xffffff);
    }
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
