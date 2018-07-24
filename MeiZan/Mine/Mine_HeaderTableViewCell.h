//
//  Mine_HeaderTableViewCell.h
//  JingXuan
//
//  Created by sfs on 2017/12/8.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface Mine_HeaderTableViewCell : BaseTableViewCell
@property (nonatomic, strong) UILabel *welcomeLabel;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *blockView;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *accountLabel;
@property (nonatomic, weak) UIViewController *myViewController;
@property (nonatomic,copy) void (^moveToChargePage)(void);
@property (nonatomic,copy) void (^moveToMyOrderPage)(NSInteger currentIndex);
- (void)createButtonWithTitlesArray:(NSArray *)array;
@end
