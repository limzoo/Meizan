//
//  MerchandiseHeaderTableViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/11.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MerchandiseHeaderTableViewCell.h"
#import "ImageModel.h"
#import "UserLoginViewController.h"
@interface MerchandiseHeaderTableViewCell()
//@property (nonatomic, strong) UIImageView *merchandiseIconImgView;
@property (nonatomic, strong) UILabel *replyNum;
@property (nonatomic, strong) UILabel *merchandiseNameLabel;
//@property (nonatomic, strong) UILabel *merchandiseIntro;
@property (nonatomic, strong) UILabel *merchandisePrice;
//@property (nonatomic, strong) UIButton *merchantNameButton;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end
@implementation MerchandiseHeaderTableViewCell
- (void)createSubview{
    self.cycleScrollView = [[SDCycleScrollView alloc] init];
    [self.contentView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(self.cycleScrollView.mas_width).multipliedBy(280/375.0);
    }];
    
    UIView *verticalLine = [[UIView alloc] init];
    verticalLine.backgroundColor = INSETCOLOR;
    [self.contentView addSubview:verticalLine];
    [verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom);
        make.width.mas_equalTo(1);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(98));
        make.bottom.mas_equalTo(self.contentView);
    }];
    //右边一个辅助view而已
    UIView *rightAssitView = [[UIView alloc] init];
    [self.contentView addSubview:rightAssitView];
    [rightAssitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom);
        make.trailing.bottom.mas_equalTo(self.contentView);
        make.leading.mas_equalTo(verticalLine.mas_trailing);
    }];
    
    self.replyNum = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Medium" size:18] color:STYLECOLOR text:@"999+"];
    [rightAssitView addSubview:self.replyNum];
    [self.replyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom).offset(8);
        make.centerX.mas_equalTo(rightAssitView);
    }];
    
    UILabel *const_replyNum = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:STYLECOLOR text:@"用户评价"];
    [rightAssitView addSubview:const_replyNum];
    [const_replyNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(rightAssitView);
        make.top.mas_equalTo(self.replyNum.mas_bottom).offset(4);
    }];
    
    self.lookButton = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:COLOR_RGB16(0xffffff) cornerRadius:0 fontSize:14 title:@"查看"];
    self.lookButton.layer.borderWidth = 1;
    self.lookButton.layer.borderColor = COLOR_RGB16(0x979797).CGColor;
    [rightAssitView addSubview:self.lookButton];
    [self.lookButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(rightAssitView);
        make.top.mas_equalTo(const_replyNum.mas_bottom).offset(6);
        make.width.mas_equalTo(CUSTOM_WIDTH(36));
        make.height.mas_equalTo(22);
    }];
    
    self.merchandiseNameLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TITLECOLOR text:@"商品名称"];
    [self.contentView addSubview:self.merchandiseNameLabel];
    [self.merchandiseNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom).offset(14);
        make.trailing.mas_equalTo(verticalLine.mas_leading).offset(-CUSTOM_WIDTH(14));
    }];
    
//    self.merchandiseIntro = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"introintrointrointrointrointrointro"];
//    [self.contentView addSubview:self.merchandiseIntro];
//    [self.merchandiseIntro mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(self.contentView.mas_leading).offset(CUSTOM_WIDTH(14));
//        make.top.mas_equalTo(self.merchandiseNameLabel.mas_bottom).offset(8);
//        make.trailing.mas_equalTo(verticalLine.mas_leading).offset(-CUSTOM_WIDTH(14));
//    }];
//
    
//    NSString *priceStr = @"¥12.9";
//    NSString *oldPriceStr = @"   ¥100.00";
//    NSMutableAttributedString *mixPriceStr = [[NSMutableAttributedString alloc] initWithString:[priceStr stringByAppendingString:oldPriceStr] attributes:nil];
//    [mixPriceStr addAttribute:NSFontAttributeName value: [UIFont fontWithName:@"PingFangSC-Regular" size:18] range:NSMakeRange(0, 1)];
//    [mixPriceStr addAttribute:NSFontAttributeName value: [UIFont fontWithName:@"PingFangSC-Regular" size:30] range:NSMakeRange(1, priceStr.length - 1)];
//    [mixPriceStr addAttribute:NSForegroundColorAttributeName value:STYLECOLOR range:NSMakeRange(0, priceStr.length)];
//    [mixPriceStr addAttribute:NSForegroundColorAttributeName value:COLOR_RGB16(0x999999) range:NSMakeRange(priceStr.length, oldPriceStr.length)];
//    [mixPriceStr addAttribute:NSStrikethroughStyleAttributeName value:@1 range:NSMakeRange(priceStr.length + 3, oldPriceStr.length - 3)];
//    [mixPriceStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:12] range:NSMakeRange(priceStr.length, oldPriceStr.length)];
//
    self.merchandisePrice = [[UILabel alloc] init];
//    self.merchandisePrice.attributedText = mixPriceStr;
    self.merchandisePrice.userInteractionEnabled = YES;
    [self.merchandisePrice addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveToLoginPage:)]];
    [self.contentView addSubview:self.merchandisePrice];
    [self.merchandisePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView.mas_leading).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.merchandiseNameLabel.mas_bottom).offset(8);
    }];
    
    
//    self.merchantNameButton = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0xffa000) backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@"商家名称 >"];
//    self.merchantNameButton.layer.borderWidth = 1;
//    self.merchantNameButton.layer.borderColor = COLOR_RGB16(0xffa000).CGColor;
//    [self.contentView addSubview:self.merchantNameButton];
//    [self.merchantNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
//        make.top.mas_equalTo(self.merchandisePrice.mas_bottom).offset(8);
//        make.height.mas_equalTo(22);
//        make.width.mas_equalTo([self.merchantNameButton.currentTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width + 20);
//    }];
    //没办法,手动画了一个分割线
    UIView *insetLineView = [[UIView alloc] init];
    insetLineView.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:insetLineView];
    [insetLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(8);
    }];
}

- (void)setModel:(MerchandiseDetailModel *)model{
    _model = model;
    _replyNum.text = [NSString stringWithFormat:@"%ld",model.count.integerValue];
    _merchandiseNameLabel.text = model.goodsName;
    
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    NSString *priceStr;
    NSString *oldPriceStr;
    NSString *monthSell;
    //用户类型(1.商户;2个人;3总代理商;4县代理商)
    switch (config.userInfo.userType.intValue) {
        case 1:{
            priceStr = [NSString stringWithFormat:@"¥%.2f",model.price.floatValue];;
            oldPriceStr = [NSString stringWithFormat:@"   ¥%.2f",model.realPrice.floatValue];
            monthSell = [NSString stringWithFormat:@"   月销%ld笔",model.salesCount.integerValue];
            break;
        }
        case 2:{
            priceStr = [NSString stringWithFormat:@"¥%.2f",model.price.floatValue];
            oldPriceStr = [NSString stringWithFormat:@"   ¥%.2f",model.realPrice.floatValue];
             monthSell = [NSString stringWithFormat:@"   月销%ld笔",model.salesCount.integerValue];
            break;
        }
        case 3:{
            priceStr = [NSString stringWithFormat:@"¥%.2f",model.mainAgentPrice.floatValue];
            oldPriceStr = [NSString stringWithFormat:@"   ¥%.2f",model.realPrice.floatValue];
             monthSell = [NSString stringWithFormat:@"   月销%ld笔",model.salesCount.integerValue];
            break;
        }
        case 4:{
            priceStr = [NSString stringWithFormat:@"¥%.2f",model.countyAgentPrice.floatValue];
            oldPriceStr = [NSString stringWithFormat:@"   ¥%.2f",model.realPrice.floatValue];
             monthSell = [NSString stringWithFormat:@"   月销%ld笔",model.salesCount.integerValue];
            break;
        }
        default:
           priceStr = @"请登录后查看";
           oldPriceStr = @"";
            monthSell = @"";
            break;
    }
    if (model.price == 0) {
       priceStr = [NSString stringWithFormat:@"需要%ld积分",model.point.integerValue];
        oldPriceStr = @"";
          monthSell = @"";
    }
   
    NSMutableAttributedString *mixPriceStr = [[NSMutableAttributedString alloc] initWithString:[[priceStr stringByAppendingString:oldPriceStr] stringByAppendingString:monthSell] attributes:nil];
    [mixPriceStr addAttribute:NSForegroundColorAttributeName value:STYLECOLOR range:NSMakeRange(0, priceStr.length)];
    [mixPriceStr addAttribute:NSForegroundColorAttributeName value:COLOR_RGB16(0x999999) range:NSMakeRange(priceStr.length, oldPriceStr.length + monthSell.length)];
    if (oldPriceStr.length != 0) {
        [mixPriceStr addAttribute:NSFontAttributeName value: [UIFont fontWithName:@"PingFangSC-Regular" size:18] range:NSMakeRange(0, 1)];
        [mixPriceStr addAttribute:NSFontAttributeName value: [UIFont fontWithName:@"PingFangSC-Regular" size:30] range:NSMakeRange(1, priceStr.length - 1)];
        
//        [mixPriceStr addAttribute:NSStrikethroughStyleAttributeName value:@1 range:NSMakeRange(priceStr.length + 3, oldPriceStr.length - 3)];
        
          [mixPriceStr addAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle], NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)} range:NSMakeRange(priceStr.length + 3, oldPriceStr.length - 3)];;//解决iOS10.3中划线失效
        
        [mixPriceStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFangSC-Regular" size:12] range:NSMakeRange(priceStr.length, oldPriceStr.length + monthSell.length)];
    }else{
        [mixPriceStr addAttribute:NSFontAttributeName value: [UIFont fontWithName:@"PingFangSC-Regular" size:24] range:NSMakeRange(0, priceStr.length)];
    }
    _merchandisePrice.attributedText = mixPriceStr;
   
    
}

- (void)setGoodsImageArray:(NSArray *)goodsImageArray{
    _goodsImageArray = goodsImageArray;
    NSMutableArray *tempPicArray = [[NSMutableArray alloc] init];;
    for (ImageModel *imgModel in goodsImageArray) {
        [tempPicArray addObject:imgModel.imageUrl];
    }
    self.cycleScrollView.imageURLStringsGroup = tempPicArray;
}
/*@property (nonatomic, strong) UIImageView *merchandiseIconImgView;
 @property (nonatomic, strong) UILabel *replyNum;
 @property (nonatomic, strong) UILabel *merchandiseNameLabel;
 //@property (nonatomic, strong) UILabel *merchandiseIntro;
 @property (nonatomic, strong) UILabel *merchandisePrice;
 //@property (nonatomic, strong) UIButton *merchantNameButton;
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)moveToLoginPage:(UITapGestureRecognizer *)rec{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]) {
    [[Tool getCurrentVC].navigationController pushViewController:[[UserLoginViewController alloc]init] animated:YES];
    }
}
@end
