//
//  NormalCustomTableViewCell.h
//  MeiZan
//
//  Created by 林宇 on 2018/2/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, NormalCustomCellStyle){
    LeftLabelRightLabelStyle,
    LeftImageWithLabelStyle,
    LeftImageWithLabelRightImageSytle,
    LeftLabelRightTextfieldStyle,
};
@interface NormalCustomTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UITextField *rightTextField;
@property (nonatomic, assign) BOOL hasArrow;
@property (nonatomic, strong) id model;
@property (nonatomic,copy) void (^modelValueWithView)(id model, NormalCustomTableViewCell *cell);
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier customStyle:(NormalCustomCellStyle)cellStyle;
@end
