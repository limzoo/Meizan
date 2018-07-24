
//
//  SearchListTableViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/11.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "SearchListTableViewCell.h"
#import "ItemCollectionView.h"
@interface SearchListTableViewCell()
@property (nonatomic, strong) ItemCollectionView *serviceCollectionView;
@end
@implementation SearchListTableViewCell


- (void)createSubview{
    UIView *typeChooseView = [[UIView alloc] init];
    [typeChooseView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTypeChooseView:)]];
    [self.contentView addSubview:typeChooseView];
    [typeChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *const_TypeChooselabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:TEXTCOLOR text:@"规格数量选择"];
    [typeChooseView addSubview:const_TypeChooselabel];
    [const_TypeChooselabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(typeChooseView).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(typeChooseView);
    }];
    
    UIImageView *arrowIMGV_1 = [[UIImageView alloc] init];
    arrowIMGV_1.image = [UIImage imageNamed:@"rightArrow"];
    [typeChooseView addSubview:arrowIMGV_1];
    [arrowIMGV_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(13);
        make.centerY.mas_equalTo(typeChooseView);
        make.trailing.mas_equalTo(typeChooseView).offset(-CUSTOM_WIDTH(14));
    }];
    
    UIView *lineView_1 = [[UIView alloc] init];
    lineView_1.backgroundColor = INSETCOLOR;
    [self.contentView addSubview:lineView_1];
    [lineView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(typeChooseView.mas_bottom);
    }];
    
    UIView *receiveCouponView = [[UIView alloc] init];
    [self.contentView addSubview:receiveCouponView];
    [receiveCouponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(lineView_1.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
//    UILabel *const_receiveCoupon = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:TEXTCOLOR text:@"用户评价（999+）"];
//    [receiveCouponView addSubview:const_receiveCoupon];
//    [const_receiveCoupon mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(receiveCouponView).offset(CUSTOM_WIDTH(14));
//        make.centerY.mas_equalTo(receiveCouponView);
//    }];
//    
//    UIImageView *arrowIMGV_2 = [[UIImageView alloc] init];
//       arrowIMGV_2.image = [UIImage imageNamed:@"rightArrow"];
//    [receiveCouponView addSubview:arrowIMGV_2];
//    [arrowIMGV_2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(8);
//        make.height.mas_equalTo(13);
//        make.centerY.mas_equalTo(receiveCouponView);
//        make.trailing.mas_equalTo(receiveCouponView).offset(-CUSTOM_WIDTH(14));
//    }];
//    
//    UIView *lineView_2 = [[UIView alloc] init];
//    lineView_2.backgroundColor = INSETCOLOR;
//    [self.contentView addSubview:lineView_2];
//    [lineView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.trailing.mas_equalTo(self.contentView);
//        make.height.mas_equalTo(1);
//        make.top.mas_equalTo(receiveCouponView.mas_bottom);
//    }];
    
//    UILabel *const_service = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:TEXTCOLOR text:@"服务:"];
//    [receiveCouponView addSubview:const_service];
//    [const_service mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
//        make.top.mas_equalTo(lineView_2.mas_bottom).offset(20);
//        make.width.mas_equalTo(CUSTOM_WIDTH(49));
//    }];
//    
//    self.serviceCollectionView = [[ItemCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
//    self.serviceCollectionView.type = ItemCollectionViewItemTypePoint;
//    [self.contentView addSubview:self.serviceCollectionView];
//    [self.serviceCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.mas_equalTo(const_service.mas_trailing).offset(CUSTOM_WIDTH(10));
//        make.trailing.mas_equalTo(self.contentView.mas_trailing).offset(-CUSTOM_WIDTH(14));
//        make.top.mas_equalTo(const_service.mas_top);
//        make.height.mas_offset(0);
//    }];
    
    //没办法,手动画了一个分割线
    UIView *insetLineView = [[UIView alloc] init];
    insetLineView.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:insetLineView];
    [insetLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)showTypeChooseView:(UITapGestureRecognizer *)rec{
    self.showSelectView();
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setTitlesArray:(NSArray<NSString *> *)titlesArray{
    _titlesArray = titlesArray;
    self.serviceCollectionView.titlesArray = titlesArray;
    [self.serviceCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset([Tool calculateCellHeightWithArray:titlesArray width:290]);
    }];
    [self.serviceCollectionView reloadData];
}

@end
