//
//  AboutMeiZan.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "AboutMeiZan.h"
#import "LeftImageTableViewCell.h"
@interface AboutMeiZan()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *contentArray;
@end
@implementation AboutMeiZan
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"logo"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(190);
        make.height.mas_equalTo(67);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(50);
    }];
    
    UILabel *betaLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:TEXTCOLOR text:@"美赞 V1.0.0"];
    [self addSubview:betaLabel];
    [betaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(imageView.mas_bottom).offset(13);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR_F5;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(betaLabel.mas_bottom).offset(40);
        make.height.mas_equalTo(8);
    }];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.scrollEnabled = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    [tableView registerClass:[LeftImageTableViewCell class] forCellReuseIdentifier:@"LeftImageTableViewCell"];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(lineView.mas_bottom);
        make.height.mas_equalTo(240);
    }];
    
    UILabel *bottomLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:COLOR_RGB16(0x666666) text:@"湖南美赞餐饮管理有限公司\n版权所有"];
    bottomLabel.numberOfLines = 0;
    [self addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-25);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftImageTableViewCell"];
    
    cell.titleImgView.image = [UIImage imageNamed:self.titleArray[indexPath.row]];
    //    cell
    cell.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    cell.titleLabel.textColor = TEXTCOLOR;
    cell.titleLabel.text = self.contentArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"400-100-6848"];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        });
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"电话",@"传真",@"QQ",@"地址"];
    }
    return _titleArray;
}

- (NSArray *)contentArray{
    if (!_contentArray) {
        _contentArray = @[@"电话：400-100-6848（9:00 - 22:00）",@"传真：0731-82809798",@"QQ ：2338053827",@"地址：长沙市开福区中山路589号万达广场B座写字楼33009室"];
    }
    return _contentArray;
}
@end
