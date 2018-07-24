//
//  UserCommentMerchandiseTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UserCommentMerchandiseTableViewCell.h"
@interface UserCommentMerchandiseTableViewCell()<UITextFieldDelegate>
@property (nonatomic, assign) NSInteger selectType;
@end
@implementation UserCommentMerchandiseTableViewCell
- (void)selectAction:(UIButton *)sender{
    self.buttonSelectAction(sender.tag - 100);
}
- (void)createSubview{
    self.merchandiseIMGV = [[UIImageView alloc] init];
    [self addSubview:self.merchandiseIMGV];
    [self.merchandiseIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.width.height.mas_equalTo(40);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.merchandiseIMGV.mas_bottom).offset(14);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *goodButton = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0x999999) backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@"好评"];
    goodButton.tag = 101;
    [goodButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:goodButton];
    [goodButton setImage:[UIImage imageNamed:@"好评"] forState:UIControlStateNormal];
    goodButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    goodButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [goodButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.merchandiseIMGV.mas_trailing).offset(14);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(self.merchandiseIMGV);
        make.height.mas_equalTo(22);
    }];
    
    UIButton *soButton = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0x999999) backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@"一般"];
    soButton.tag = 102;
    soButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [soButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
     soButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [self.contentView addSubview:soButton];
    [soButton setImage:[UIImage imageNamed:@"中评"] forState:UIControlStateNormal];
    [soButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(goodButton.mas_trailing).offset(14);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(self.merchandiseIMGV);
        make.height.mas_equalTo(22);
    }];
    
    UIButton *badButton = [UIButton initCustomTypeButtonWithTextColor:COLOR_RGB16(0x999999) backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@"差评"];
    badButton.tag = 103;
    badButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [badButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:badButton];
      badButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [badButton setImage:[UIImage imageNamed:@"差评"] forState:UIControlStateNormal];
    [badButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(soButton.mas_trailing).offset(14);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(self.merchandiseIMGV);
        make.height.mas_equalTo(22);
    }];
    
    self.textView = [[FSTextView alloc] init];
    self.textView.delegate = self;
    self.textView.placeholderFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
     self.textView.placeholder =  @"宝贝满足你的期待吗？说说他的优点和美中不足的地方";
    self.textView.maxLength = 30;
    self.textView.placeholderColor = COLOR_RGB16(0x999999);
    [self.contentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
        make.top.mas_equalTo(lineView.mas_bottom).offset(10);
        make.height.mas_equalTo(80);
    }];
    
    self.uploadPicIMGV_1 = [[UIImageView alloc] init];
    self.uploadPicIMGV_1.userInteractionEnabled = YES;
    self.uploadPicIMGV_1.tag = 10;
    self.uploadPicIMGV_1.image = [UIImage imageNamed:@"上传照片"];
    [self.contentView addSubview:self.uploadPicIMGV_1];
    [self.uploadPicIMGV_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(72);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.textView.mas_bottom).offset(20);
    }];
    self.uploadPicIMGV_2 = [[UIImageView alloc] init];
    self.uploadPicIMGV_2.userInteractionEnabled = YES;
    self.uploadPicIMGV_2.tag = 11;
    self.uploadPicIMGV_2.image = [UIImage imageNamed:@"上传照片"];
    [self.contentView addSubview:self.uploadPicIMGV_2];
    [self.uploadPicIMGV_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(72);
        make.leading.mas_equalTo(self.uploadPicIMGV_1.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.top.mas_equalTo(self.textView.mas_bottom).offset(20);
    }];
    self.uploadPicIMGV_3 = [[UIImageView alloc] init];
    self.uploadPicIMGV_3.userInteractionEnabled = YES;
    self.uploadPicIMGV_3.tag = 12;
    self.uploadPicIMGV_3.image = [UIImage imageNamed:@"上传照片"];
    [self.contentView addSubview:self.uploadPicIMGV_3];
    [self.uploadPicIMGV_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(72);
          make.leading.mas_equalTo(self.uploadPicIMGV_2.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.top.mas_equalTo(self.textView.mas_bottom).offset(20);
    }];
    
}
- (void)setModel:(OrderMerchandiseModel *)model{
    _model = model;
    [self.merchandiseIMGV sd_setImageWithURL:[NSURL URLWithString:model.showImageUrl]];
}

- (void)setCommentModel:(UserCommentModel *)commentModel{
    _commentModel = commentModel;
    self.textView.text = commentModel.content;
    for (int i = 101; i < 104; i++) {
        UIButton *button = [self viewWithTag:i];
        if (i -  100 == commentModel.type) {
            [button setTitleColor:STYLECOLOR forState:UIControlStateNormal];
            switch (i) {
                case 101:
                    [button setImage:[UIImage imageNamed:@"好评_select"] forState:UIControlStateNormal];
                    break;
                case 102:
                     [button setImage:[UIImage imageNamed:@"中评_select"] forState:UIControlStateNormal];
                    break;
                case 103:
                     [button setImage:[UIImage imageNamed:@"差评_select"] forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
        }else{
            [button setTitleColor:COLOR_RGB16(0x999999) forState:UIControlStateNormal];
            switch (i) {
                case 101:
                    [button setImage:[UIImage imageNamed:@"好评"] forState:UIControlStateNormal];
                    break;
                case 102:
                    [button setImage:[UIImage imageNamed:@"中评"] forState:UIControlStateNormal];
                    break;
                case 103:
                    [button setImage:[UIImage imageNamed:@"差评"] forState:UIControlStateNormal];
                    break;
                default:
                    break;
            }
        }
    }
    for (int i = 10; i < 13; i++) {
        UIImageView *imgView = [self viewWithTag:i];
        if (i -  10 <= commentModel.imgArray.count) {
            imgView.hidden = NO;
            if (i - 10 < commentModel.imgArray.count) {
                imgView.image = commentModel.imgArray[i - 10];
            }else{
             imgView.image = [UIImage imageNamed:@"上传照片"];
            }
        }else{
            imgView.hidden = YES;
        }
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
