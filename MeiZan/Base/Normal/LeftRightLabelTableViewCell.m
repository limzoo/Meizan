//
//  LeftRightLabelTableViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/14.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "LeftRightLabelTableViewCell.h"
@interface LeftRightLabelTableViewCell()
@property (nonatomic, strong) UIImageView *arrowIMGV;
@end
@implementation LeftRightLabelTableViewCell
- (void)configInitial{
    self.hasArrow = YES;
}

- (void)createSubview{
    self.leftLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:nil];
    [self.contentView addSubview:self.leftLabel];
    
    self.rightLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:nil];
    [self.contentView addSubview:self.rightLabel];
    
    self.arrowIMGV = [[UIImageView alloc] init];
    self.arrowIMGV.image = [UIImage imageNamed:@"rightArrow"];
    [self.contentView addSubview:self.arrowIMGV];
    [self.arrowIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
        make.centerY.mas_equalTo(self.contentView);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
    }];
    
    self.leftLabel.textAlignment =NSTextAlignmentLeft;
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    self.rightLabel.textAlignment = NSTextAlignmentRight;
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(32));
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.height.mas_equalTo(1);
        make.bottom.trailing.mas_equalTo(self);
    }];
}

- (void)setHasArrow:(BOOL)hasArrow{
    _hasArrow = hasArrow;
    if (_hasArrow) {
        self.arrowIMGV.hidden = NO;
        [self.rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(32));
        }];

    }else{
        self.arrowIMGV.hidden = YES;
        [self.rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        }];
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
