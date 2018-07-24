//
//  ItemCollectionViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/11.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "ItemCollectionViewCell.h"
@interface ItemCollectionViewCell()
@property (nonatomic, strong) UILabel *itemLabel;
@end
@implementation ItemCollectionViewCell
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    self.itemLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:[UIColor whiteColor] text:nil];
    [self.contentView addSubview:self.itemLabel];
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.contentView);
    }];
}

- (void)setType:(ItemCollectionViewItemType)type{
    _type = type;
    switch (self.type) {
        case ItemCollectionViewItemTypeBorder:{
            self.layer.borderWidth = 1;
            break;
        }
        case ItemCollectionViewItemTypePoint:{
            //这个东西应该考虑直接drawRect里面加好一点
            UIView *point = [[UIView alloc] init];
            point.layer.cornerRadius = 3.0f;
            point.layer.masksToBounds = YES;
            point.backgroundColor = STYLECOLOR;
            [self.contentView addSubview:point];
            self.itemLabel.textColor = COLOR_RGB16(0x999999);
            [point mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(6);
                make.height.mas_equalTo(6);
                make.centerY.mas_equalTo(self.itemLabel.mas_centerY);
                make.trailing.mas_equalTo(self.itemLabel.mas_leading).offset(-CUSTOM_WIDTH(6));
            }];
            break;
        }
        default:
            break;
    }
}

- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _itemLabel.text = titleString;
}

- (void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    _itemLabel.textColor = textColor;
}

- (void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}
@end
