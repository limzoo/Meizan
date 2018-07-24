//
//  MyOrderTableViewCell.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyOrderTableViewCell.h"
#import "OrderDetailMerchandiseTableViewCell.h"
@interface MyOrderTableViewCell()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *orderDetailLabel;

@end
@implementation MyOrderTableViewCell

- (void)createSubview{
    self.tableView = [[UITableView alloc] init];
    self.tableView.userInteractionEnabled = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[OrderDetailMerchandiseTableViewCell class] forCellReuseIdentifier:@"OrderDetailMerchandiseTableViewCell.h"];
    [self.contentView addSubview:self.self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0);
    }];
    
    self.orderDetailLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.orderDetailLabel];
    self.orderDetailLabel.textAlignment = NSTextAlignmentRight;
    [self.orderDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(15);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(43);
    }];
    
    self.rightButton = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@""];
  
    self.rightButton.layer.borderWidth = 0.5;
    self.rightButton.layer.borderColor = STYLECOLOR.CGColor;
    [self.contentView addSubview:self.rightButton];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(80));
        make.height.mas_equalTo(32);
        make.top.mas_equalTo(lineView.mas_bottom).offset(12);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
    }];
    
    self.middleButton = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@""];
   
    self.middleButton.layer.borderWidth = 0.5;
    self.middleButton.layer.borderColor = TEXTCOLOR.CGColor;
    [self.contentView addSubview:self.middleButton];
    [self.middleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(80));
        make.height.mas_equalTo(32);
        make.top.mas_equalTo(lineView.mas_bottom).offset(12);
        make.trailing.mas_equalTo(self.rightButton.mas_leading).offset(-CUSTOM_WIDTH(14));
    }];
    
    self.leftButton = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@""];

    self.leftButton.layer.borderWidth = 0.5;
    self.leftButton.layer.borderColor = TEXTCOLOR.CGColor;
    [self.contentView addSubview:self.leftButton];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(80));
        make.height.mas_equalTo(32);
        make.top.mas_equalTo(lineView.mas_bottom).offset(12);
        make.trailing.mas_equalTo(self.middleButton.mas_leading).offset(-CUSTOM_WIDTH(14));
    }];
    
    UIView *bottomLineView = [[UIView alloc] init];
    bottomLineView.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(8);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.goodsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailMerchandiseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderDetailMerchandiseTableViewCell.h"];
    cell.model = self.model.goodsList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MyOrderModel *)model{
    _model = model;
    /*@property (nonatomic, strong) UILabel *orderDetailLabel;
     @property (nonatomic, strong) UIButton *rightButton;
     @property (nonatomic, strong) UIButton *leftButton;*/
    NSInteger sum = 0;
    for (OrderMerchandiseModel *orderMerchandiseModel in model.goodsList) {
        sum = sum + orderMerchandiseModel.number.integerValue;
    }
    NSString *totalNum = [NSString stringWithFormat:@"共%ld件商品,总金额: ",sum];
    NSString *totalPrice = [NSString stringWithFormat:@"%.2f元",model.COUNT_PRICE.floatValue];
    NSString *str = [totalNum stringByAppendingString:totalPrice];
    NSMutableAttributedString *targetStr = [[NSMutableAttributedString alloc] initWithString:str];
     [targetStr setAttributes:@{NSForegroundColorAttributeName:TITLECOLOR} range:NSMakeRange(0, totalNum.length)];
    [targetStr setAttributes:@{NSForegroundColorAttributeName:STYLECOLOR} range:NSMakeRange(totalNum.length, totalPrice.length)];
    self.orderDetailLabel.attributedText = targetStr;
    self.orderDetailLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    /*                case 0:{
     cell.leftButton.hidden = NO;
     cell.rightButton.hidden = NO;
     cell.middleButton.hidden = NO;
     [cell.rightButton setTitle:@"去付款" forState:UIControlStateNormal];
     [cell.middleButton setTitle:@"取消订单" forState:UIControlStateNormal];
     [cell.leftButton setTitle:@"上传凭证" forState:UIControlStateNormal];
     break;
     }
     case 1:{
     cell.rightButton.hidden = NO;
     [cell.rightButton setTitle:@"待发货" forState:UIControlStateNormal];
     break;
     }
     case 2:{
     cell.rightButton.hidden = NO;
     [cell.rightButton setTitle:@"确认收货" forState:UIControlStateNormal];
     break;
     }
     case 3:{
     cell.rightButton.hidden = NO;
     [cell.rightButton setTitle:@"去评价" forState:UIControlStateNormal];
     break;
     }
     case 4:{
     cell.rightButton.hidden = NO;
     [cell.rightButton setTitle:@"已完成" forState:UIControlStateNormal];
     break;
     }
     case 5:{
     cell.rightButton.hidden = NO;
     [cell.rightButton setTitle:@"已取消" forState:UIControlStateNormal];
     break;
     }
     case 6:{
     cell.rightButton.hidden = NO;
     [cell.rightButton setTitle:@"待审核" forState:UIControlStateNormal];
     break;
     }
     case 7:{
     cell.rightButton.hidden = NO;
     [cell.rightButton setTitle:@"审核失败" forState:UIControlStateNormal];
     break;
     }*/
    self.leftButton.hidden = YES;
    self.middleButton.hidden = YES;
    self.rightButton.hidden = YES;
    switch (model.ORDER_STATUS.intValue) {
        case 0:{
            self.rightButton.hidden = NO;
            [self.rightButton setTitle:@"去付款" forState:UIControlStateNormal];
            self.middleButton.hidden = NO;
            [self.middleButton setTitle:@"取消订单" forState:UIControlStateNormal];
            if ([model.PAYMENT_WAY isEqualToString:@"4"]) {
                self.leftButton.hidden = NO;
                [self.leftButton setTitle:@"上传凭证" forState:UIControlStateNormal];
            }
            break;
        }
        case 1:{
            self.rightButton.hidden = NO;
            [self.rightButton setTitle:@"待发货" forState:UIControlStateNormal];
            break;
        }
        case 2:{
            self.rightButton.hidden = NO;
            [self.rightButton setTitle:@"确认收货" forState:UIControlStateNormal];
            break;
        }
        case 3:{
            self.rightButton.hidden = NO;
            [self.rightButton setTitle:@"去评价" forState:UIControlStateNormal];
            break;
        }
        case 4:{
            self.rightButton.hidden = NO;
            [self.rightButton setTitle:@"已完成" forState:UIControlStateNormal];
            break;
        }
        case 5:{
            self.rightButton.hidden = NO;
            [self.rightButton setTitle:@"已取消" forState:UIControlStateNormal];
            break;
        }
        case 6:{
            self.rightButton.hidden = NO;
            [self.rightButton setTitle:@"审核中" forState:UIControlStateNormal];
            self.middleButton.hidden = YES;
            [self.middleButton setTitle:@"取消订单" forState:UIControlStateNormal];
            self.leftButton.hidden = YES;
            break;
        }
        case 7:{
            self.rightButton.hidden = NO;
            [self.rightButton setTitle:@"审核失败" forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(model.goodsList.count * 120);
    }];
    [self.tableView reloadData];
}

@end
