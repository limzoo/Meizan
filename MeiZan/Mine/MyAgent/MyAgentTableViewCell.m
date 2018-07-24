//
//  MyAgentTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyAgentTableViewCell.h"
@interface MyAgentTableViewCell()
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *addressLabel;
@end
@implementation MyAgentTableViewCell
- (void)createSubview{
    self.nameLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:nil];
    [self.contentView addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self).offset(10);
    }];
    
    self.addressLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color: COLOR_RGB16(0x999999) text:nil];
    [self.contentView addSubview:self.addressLabel];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLabel);
         make.bottom.mas_equalTo(self).offset(-8);
    }];
    
    self.detailLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color: COLOR_RGB16(0x999999) text:nil];
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(self.addressLabel.mas_top).offset(-8);
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

- (void)setModel:(MyAgentModel *)model{
    _model = model;
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    self.nameLabel.text = nil;
    switch (model.USER_TYPE.integerValue) {
        case 1:
            if (self.indexPath.row == 0) {
                if ([config.userInfo.userType isEqualToString:@"3"]) {
                     self.nameLabel.text = @"(总代下属店铺)";
                }else{
                     self.nameLabel.text = @"(县代下属店铺)";
                }
            }else{
                self.nameLabel.text = @"(县代下属店铺)";
            }
            break;
        case 2:
             self.nameLabel.text = @"(个人)";
            break;
        case 3:
             self.nameLabel.text = @"(总代理)";
            break;
        case 4:
             self.nameLabel.text = @"(县代理)";
            break;
        default:
            break;
    }
    self.nameLabel.text = [self.nameLabel.text stringByAppendingString: model.MERCHANT_NAME];
    self.detailLabel.text = [model.REAL_NAME stringByAppendingString:[NSString stringWithFormat:@" %@",[model.MOBILE_NO stringByAppendingString:[NSString stringWithFormat:@" %@",model.CREATE_TIME]]]];
    self.addressLabel.text = model.MERCHANT_ADDRESS;
}

- (void)setShouldHaveLeftInset:(BOOL)shouldHaveLeftInset{
    _shouldHaveLeftInset = shouldHaveLeftInset;
    if (shouldHaveLeftInset) {
        [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(54));
        }];
    }else{
        [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        }];
    }
}
@end
