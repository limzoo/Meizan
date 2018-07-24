//
//  MyOrderDetailView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/24.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyOrderDetailView.h"
#import "LeftImageTableViewCell.h"
#import "MyOrderDetailAddressTableViewCell.h"
#import "LeftRightLabelTableViewCell.h"
#import "MyOrderBottomTableViewCell.h"
#import "MyOrderDetailMerchandiseTableViewCell.h"
#import "MyOrderDeliverDetailTableViewCell.h"
#import "UploadVoucherViewController.h"
#import "MyOrderDetailViewController.h"
#import "SelectPayStyleViewController.h"
#import "UserCommentViewController.h"
@interface MyOrderDetailView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *content_0;
@property (nonatomic, strong) NSArray *content_2;
@end
@implementation MyOrderDetailView
- (void)createSubview{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[LeftImageTableViewCell class] forCellReuseIdentifier:@"LeftImageTableViewCell"];
    [self.tableView registerClass:[MyOrderDetailAddressTableViewCell class] forCellReuseIdentifier:@"MyOrderDetailAddressTableViewCell"];
    [self.tableView registerClass:[LeftRightLabelTableViewCell class] forCellReuseIdentifier:@"LeftRightLabelTableViewCell"];
    [self.tableView registerClass:[MyOrderDetailMerchandiseTableViewCell class] forCellReuseIdentifier:@"MyOrderDetailMerchandiseTableViewCell"];
    [self.tableView registerClass:[MyOrderBottomTableViewCell class] forCellReuseIdentifier:@"MyOrderBottomTableViewCell"];
    [self.tableView registerClass:[MyOrderDeliverDetailTableViewCell class] forCellReuseIdentifier:@"MyOrderDeliverDetailTableViewCell"];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.bottom.mas_equalTo(self);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return self.orderModel.goodsList.count;
            break;
        case 5:
            return 1;
            break;
        case 6:
            if (self.orderModel.DELIVERY_TIME) {
                return 1;
            }
            return 0;
            break;
        case 7:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return 44;
            break;
        case 1:
            return 80;
            break;
        case 2:
            return 50;
            break;
        case 3:
            return 50;
            break;
        case 4:
            return 112;
            break;
        case 5:
            return 44;
            break;
        case 6:
            return 84;
            break;
        case 7:
            return 108;
            break;
        default:
            break;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = COLOR_RGB16(0xfafafa);
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 20;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 5 || section == 4) {
        return 0;
    }
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = COLOR_RGB16(0xfafafa);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            NSArray *titleArray_0 = @[@"订单状态",@"订单号",@"订单时间"];
            LeftRightLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftRightLabelTableViewCell"];
            cell.leftLabel.text = titleArray_0[indexPath.row];
            cell.leftLabel.textColor = TITLECOLOR;
            cell.rightLabel.textColor = TITLECOLOR;
            cell.rightLabel.text = self.content_0[indexPath.row];
            cell.hasArrow =  NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            break;
            
        }
        case 1:{
            MyOrderDetailAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderDetailAddressTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.nameLabel.text = self.orderModel.CONSIGNEE;
            cell.stateLabel.hidden = YES;
            cell.phoneLabel.text = self.orderModel.MOBILE_NO;
            cell.addressLabel.text = [[self.orderModel.PROVINCE stringByAppendingString:self.orderModel.CITY] stringByAppendingString:self.orderModel.ADDRESS];
            return cell;
            break;
            
        }
        case 2:{
            LeftRightLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftRightLabelTableViewCell"];
            NSArray *titleArray_2 = @[@"商品合计",@"优惠",@"合计"];
            cell.leftLabel.text = titleArray_2[indexPath.row];
            cell.leftLabel.textColor = TEXTCOLOR;
            cell.leftLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
            cell.rightLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
            if (indexPath.row == 3) {
                cell.rightLabel.textColor = STYLECOLOR;
            }else{
                cell.rightLabel.textColor = TEXTCOLOR;
            }
            cell.rightLabel.text = self.content_2[indexPath.row];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.hasArrow =  NO;
            return cell;
            break;
            
        }
        case 3:{
            LeftRightLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftRightLabelTableViewCell"];
            NSArray *titleArray_3 = @[@"发票类型"];
            cell.leftLabel.text = titleArray_3[indexPath.row];
            cell.leftLabel.textColor = TEXTCOLOR;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.hasArrow =  NO;
            cell.leftLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
            cell.rightLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
            cell.rightLabel.textColor = TEXTCOLOR;
            switch (self.orderModel.INVOICE_TYPE.intValue) {
                case 0:
                    cell.rightLabel.text = @"无需发票";
                    break;
                case 1:
                    cell.rightLabel.text = @"个人发票";
                    break;
                case 2:
                    cell.rightLabel.text = @"公司发票";
                    break;
                default:
                    break;
            }
            return cell;
            break;
            
        }
        case 4:{
            MyOrderDetailMerchandiseTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"MyOrderDetailMerchandiseTableViewCell"];
            OrderMerchandiseModel *model = self.orderModel.goodsList[indexPath.row];
            cell.model = model;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            break;
            
        }
        case 5:{
            LeftRightLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftRightLabelTableViewCell"];
            cell.leftLabel.text = @"配送方式";
            cell.rightLabel.text = @"配送上门";
            cell.leftLabel.textColor = TITLECOLOR;
            cell.rightLabel.textColor = TITLECOLOR;
            cell.hasArrow =  NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            break;
            
        }
        case 6:{
            MyOrderDeliverDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderDeliverDetailTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.deliverMsg.text = [NSString stringWithFormat:@"快递编号：%@", [[self.responseObject objectForKey:@"orderInfo"] objectForKey:@"LOGISTICS_NUMBER"]];
            cell.delieverTime.text = [NSString stringWithFormat:@"快递编号：%@", [[self.responseObject objectForKey:@"orderInfo"] objectForKey:@"DELIVERY_TIME"]];
            return cell;
            break;
            
        }
        case 7:{
            MyOrderBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderBottomTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.leftButton.hidden = YES;
             cell.middleButton.hidden = YES;
             cell.rightButton.hidden = YES;
            [cell.leftButton addTarget:self action:@selector(leftAction:) forControlEvents:UIControlEventTouchUpInside];
             [cell.middleButton addTarget:self action:@selector(middleAction:) forControlEvents:UIControlEventTouchUpInside];
             [cell.rightButton addTarget:self action:@selector(rightAction:) forControlEvents:UIControlEventTouchUpInside];
              //(0-待支付1-已支付2-已发货3-已确认4-已评价5-已取消6-待审核7-审核失败)
            switch (self.orderModel.ORDER_STATUS.integerValue) {
                case 0:{
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
                }
                default:
                    break;
            }
            return cell;
            break;
        }
        default:
            break;
    }
    return nil;
}
- (void)setOrderModel:(MyOrderModel *)orderModel{
    _orderModel = orderModel;
    NSString *orderState;
    //(0-待支付1-已支付2-已发货3-已确认4-已评价5-已取消6-待审核7-审核失败)
    switch (orderModel.ORDER_STATUS.intValue) {
        case 0:
            orderState = @"待支付";
            break;
        case 1:
            orderState = @"已支付";
            break;
        case 2:
            orderState = @"已发货";
            break;
        case 3:
            orderState = @"已确认";
            break;
        case 4:
            orderState = @"已评价";
            break;
        case 5:
            orderState = @"已取消";
            break;
        case 6:
            orderState = @"待审核";
            break;
        case 7:
            orderState = @"待审核";
            break;
        default:
            break;
    }
    self.content_0 = @[orderState, [NSString stringWithFormat:@"%ld",orderModel.ORDER_NO.integerValue], orderModel.CREATE_TIME];
    //@[@"商品合计",@"优惠",@"运费",@"合计"];
    self.content_2 = @[[NSString stringWithFormat:@"%.2f",orderModel.PRICE.floatValue - orderModel.DELIVER_MONEY.floatValue],
                       [NSString stringWithFormat:@"%.2f",orderModel.DISCOUNT_PRICE.floatValue],
                       [NSString stringWithFormat:@"%.2f",orderModel.PRICE.floatValue]];
    [self.tableView reloadData];
}

- (void)leftAction:(UIButton *)button{
    switch (self.orderModel.ORDER_STATUS.intValue) {
        case 0:{
            UploadVoucherViewController *vc = [[UploadVoucherViewController alloc] initWithModel:self.orderModel];
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}

- (void)rightAction:(UIButton *)button{
    switch (self.orderModel.ORDER_STATUS.intValue) {
        case 0:{
            SelectPayStyleViewController *vc =[[SelectPayStyleViewController alloc] initWithOrderModel:self.orderModel];
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:{
            UserCommentViewController *vc = [[UserCommentViewController alloc] initWithModel:self.orderModel];
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            [((MyOrderDetailViewController *)self.myViewController) updateOrder:self.orderModel status:3];
            break;
        }
        default:
            break;
    }
}

- (void)middleAction:(UIButton *)button{
    switch (self.orderModel.ORDER_STATUS.intValue) {
        case 0:{
            [((MyOrderDetailViewController *)self.myViewController) updateOrder:self.orderModel status:5];
            break;
        }
        default:
            break;
    }
    
}
- (void)setResponseObject:(NSDictionary *)responseObject{
    _responseObject = responseObject;
    [self.tableView reloadData];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
