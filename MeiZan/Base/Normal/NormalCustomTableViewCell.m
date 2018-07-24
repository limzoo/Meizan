//
//  NormalCustomTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/2/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "NormalCustomTableViewCell.h"
@interface NormalCustomTableViewCell()
@property (nonatomic, strong) UIImageView *arrowIMGV;
@end
@implementation NormalCustomTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier customStyle:(NormalCustomCellStyle)cellStyle{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configInitial];
        [self createSubViewWithCellStyle:cellStyle];
    }
    return self;
}

- (void)configInitial{
    
}

- (void)createSubViewWithCellStyle:(NormalCustomCellStyle)style{
    /*    LeftLabelRightLabelStyle,
    LeftImageWithLabelStyle,
    LeftImageWithLabelRightImageSytle,
    LeftImageRightLabelStyle,
    LeftLabelRightTextfieldStyle,*/
    switch (style) {
        case LeftLabelRightLabelStyle:{
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
            break;
        }
        case LeftImageWithLabelRightImageSytle:{
            self.leftImageView = [[UIImageView alloc] init];
            [self.contentView addSubview:self.leftImageView];
            [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.width.mas_equalTo(32);
                make.centerY.mas_equalTo(self.contentView);
                make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
            }];
            
            self.leftLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@""];
            [self.contentView addSubview:self.leftLabel];
            [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.contentView);
                make.leading.mas_equalTo(self.leftImageView.mas_trailing).offset(CUSTOM_WIDTH(10));
            }];
            
            self.rightImageView = [[UIImageView alloc] init];
            [self.contentView addSubview:self.rightImageView];
            [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(18);
                make.centerY.mas_equalTo(self.contentView);
                make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
            }];
            break;
        }
        case LeftLabelRightTextfieldStyle:{
            self.leftLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:nil];
            [self.contentView addSubview:self.leftLabel];
            [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self);
                make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
            }];
            
            self.rightTextField = [[UITextField alloc] init];
            [self.contentView addSubview:self.rightTextField];
            [self.rightTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self);
                make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
                make.width.mas_equalTo(CUSTOM_WIDTH(150));
                make.height.mas_equalTo(20);
            }];
            break;
        }
        default:
            break;
    }
    UIView *inset_line = [[UIView alloc] init];
    inset_line.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:inset_line];
    [inset_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(1);
        make.bottom.trailing.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(CUSTOM_WIDTH(14));
    }];
}

- (void)setHasArrow:(BOOL)hasArrow{
    _hasArrow = hasArrow;
//    if (_hasArrow) {
//        self.arrowIMGV.hidden = NO;
//        [self.rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(32));
//        }];
//
//    }else{
//        self.arrowIMGV.hidden = YES;
//        [self.rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
//        }];
//    }
}

- (void)setModel:(id)model{
    _model = model;
    __weak typeof(self) weakSelf = self;
    !_modelValueWithView ?  :  self.modelValueWithView(model, weakSelf);
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
