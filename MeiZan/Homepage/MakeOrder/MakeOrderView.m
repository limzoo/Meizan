//
//  MakeOrderView.m
//  JingXuan
//
//  Created by sfs on 2017/12/14.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MakeOrderView.h"
#import "AddressSelectTableViewCell.h"
#import "LeftRightLabelTableViewCell.h"
#import "AddAddressViewController.h"
#import "LeftImageTableViewCell.h"
#import "ImageSelectTableViewCell.h"
#import "DataPickerView.h"
#import "AddAddressViewController.h"
#import "MakeOrderViewController.h"
#import "BankSelectView.h"
#import "BankModel.h"
#import "BankSelectViewTableViewCell.h"
#import "AddressManageViewController.h"
#import "AddInvoiceViewController.h"
#import "ManageInvoiceViewController.h"
#import "SetPayPasswordViewController.h"
#import "InputPasswordView.h"
#import "OrderMerchadiseLisetViewController.h"
#import "PaymentModel.h"
#import "VerifyUserViewController.h"
@interface MakeOrderView()<UITableViewDelegate, UITableViewDataSource, PICKVIEWDELEGATE>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UILabel *shouldPayLabel;
@property (nonatomic, strong) UIButton *payButton;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *contentArray;
@property (nonatomic, strong) NSArray *payStyleArray;
@property (nonatomic, strong) DataPickerView *datePicker;

@property (nonatomic, assign) NSInteger payment;
@property (nonatomic, strong) BankSelectView *bankSelectView;
@property (nonatomic, strong) NSString *invoiceStr;

@end
@implementation MakeOrderView
// 清除和完成按钮 点击事件
- (void)configInitial{
    self.payment = -1;
    self.deliverTime = @"";
}

- (void)butControl:(NSInteger)tag{
    if (tag == 0) {
        [UIView animateWithDuration:0.7 animations:^{
            [self.maskView setHidden:YES];
        } completion:^(BOOL finished) {
            if (finished) {
                self.deliverTime = nil;
            }
        }];
    }else{
        self.deliverTime = [NSString stringWithFormat:@"%ld-%ld-%ld",self.datePicker.currentYear,self.datePicker.currentMonth,self.datePicker.currentDay];
        [UIView animateWithDuration:0.7 animations:^{
            [self.maskView setHidden:YES];
        } completion:^(BOOL finished) {
            [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
    self.datePicker.hidden = YES;
}

// 用户在选择器选择时
- (void)pickerViewSelectComponent:(NSInteger)component andRow:(NSInteger)row{
    ;
}


- (void)setUserAddressArray:(NSMutableArray *)userAddressArray{
    _userAddressArray = userAddressArray;
    [self.mainTableView reloadData];
}

- (void)createSubview{
    self.maskView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    self.maskView.backgroundColor =  [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5/1.0];
    self.maskView.hidden = YES;
    
    NSDate *date = [NSDate date]; // 获得时间对象
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    NSDate *dateNow = [date dateByAddingTimeInterval:time];
    
    self.datePicker = [[DataPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 340) currentDate:dateNow];
    
    self.datePicker.hidden = YES;
    self.datePicker.pickerStyle = 1;
    self.datePicker.titleText = @"选择日期";
    self.datePicker.pvDelegate = self;
    [self.maskView addSubview:self.datePicker];
    self.datePicker.center = self.maskView.center;
    
    self.bankSelectView = [[BankSelectView alloc] init];
    __weak typeof(self) weakSelf = self;
    self.bankSelectView.cancelButtonAction = ^{
        [weakSelf bankSelectViewCancelAction];
    };
    
    self.bankSelectView.ensureButtonAction = ^(NSInteger index) {
        [weakSelf bankSelectViewEnsureAction:index];
    };
    self.bankSelectView.hidden = YES;
    [self.maskView addSubview:self.bankSelectView];
    [self.bankSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.maskView);
        make.height.mas_equalTo(0);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = COLOR_RGB16(0xfafafa);
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.mas_equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    self.inputPasswordView = [[InputPasswordView alloc] init];
    self.inputPasswordView.backgroundColor = [UIColor whiteColor];
    self.inputPasswordView.hidden = YES;
    [self.inputPasswordView.cancelButton addTarget:self action:@selector(cancelInput:) forControlEvents:UIControlEventTouchUpInside];
    [self.maskView addSubview:self.inputPasswordView];
    [self.inputPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.maskView);
        make.height.mas_equalTo(400);
    }];
    [self.inputPasswordView.forgetButton addTarget:self action:@selector(moveToResetTradePasswordPage) forControlEvents:UIControlEventTouchUpInside];
    self.inputPasswordView.verifyPayPassword = ^(NSString *password) {
        [((MakeOrderViewController *)weakSelf.myViewController) verifyPayPassword:password];
    };
    
    
    self.inputView.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.mas_equalTo(bottomView);
        make.height.mas_equalTo(1);
    }];
    
    self.shouldPayLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:16] color:STYLECOLOR text:@"应付:¥940.00"];
    [bottomView addSubview:self.shouldPayLabel];
    [self.shouldPayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(bottomView).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(bottomView);
    }];
    
    self.payButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:0 fontSize:16 title:@"去付款"];
    [self addSubview:self.payButton];
    [self.payButton addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
    [self.payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(bottomView.mas_trailing);
        make.bottom.trailing.mas_equalTo(self);
        make.height.mas_equalTo(bottomView);
        make.width.mas_equalTo(CUSTOM_WIDTH(110));
    }];
    
    self.mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[AddressSelectTableViewCell class] forCellReuseIdentifier:@"AddressSelectTableViewCell"];
    [self.mainTableView registerClass:[LeftRightLabelTableViewCell class] forCellReuseIdentifier:@"LeftRightLabelTableViewCell"];
    [self.mainTableView registerClass:[LeftImageTableViewCell class] forCellReuseIdentifier:@"LeftImageTableViewCell"];
    [self.mainTableView registerClass:[ImageSelectTableViewCell class] forCellReuseIdentifier:@"ImageSelectTableViewCell"];
    [self.mainTableView registerClass:[BankSelectViewTableViewCell class] forCellReuseIdentifier:@"BankSelectViewTableViewCell"];
    [self addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(bottomView.mas_top);
    }];
}



- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self endEditing:YES];
}
- (void)moveToResetTradePasswordPage{
    [self.inputPasswordView.passwordField resignFirstResponder];
    self.maskView.hidden = YES;
    self.inputPasswordView.hidden = YES;
    [self.myViewController.navigationController pushViewController:[[VerifyUserViewController alloc] init] animated:YES];
}
- (void)bankSelectViewEnsureAction:(NSInteger)index{
    [UIView animateWithDuration:0.7 animations:^{
        self.selectBankModel = self.bankArray[index];
        self.maskView.hidden = YES;
        self.bankSelectView.hidden = YES;
    } completion:^(BOOL finished) {
        if (finished) {
           [self.mainTableView reloadSections:[NSIndexSet indexSetWithIndex:5] withRowAnimation:UITableViewRowAnimationNone];
        }
    }];
}

- (void)bankSelectViewCancelAction{
    [UIView animateWithDuration:0.7 animations:^{
        self.maskView.hidden = YES;
        self.bankSelectView.hidden = YES;
    }];
}
- (void)cancelInput:(UIButton *)sender{
    [self.inputPasswordView.passwordField resignFirstResponder];
    [UIView animateWithDuration:0.7 animations:^{
        self.maskView.hidden = YES;
        self.inputPasswordView.hidden = YES;
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return self.titleArray.count;
            break;
        case 3:
            return self.paymentStyleArray.count;
            break;
        case 4:
            return 2;
            break;
        case 5:{
            if (self.selectBankModel) {
                return 1;
            }else{
                return 0;
            }
            break;
        }
        case 6:
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
            return 90;
            break;
        case 1:
            if (indexPath.row == 0) {
                return 49;
            }
            return 88;
            break;
        case 2:
            return 49;
            break;
        case 3:
            return 61;
            break;
        case 4:
            return 61;
            break;
        case 5:
            return 60;
            break;
        case 6:
            return 49;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            AddressSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressSelectTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (self.currentAddressModel != nil) {
                cell.model = self.currentAddressModel;
            }else{
                for (UserAddressModel *model in self.userAddressArray) {
                    if ([model.isDefault isEqualToString:@"1"]) {
                        self.currentAddressModel = model;
                        cell.model = model;
                         break;
                    }
                }
            }
            return cell;
            break;
        }
        case 1:{
            if (indexPath.row == 0) {
                LeftRightLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftRightLabelTableViewCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.hasArrow = YES;
                cell.leftLabel.text = @"期望送货时间";
                cell.rightLabel.text = self.deliverTime;
                return cell;
            }else{
                ImageSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImageSelectTableViewCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                NSMutableArray *photoArray = [NSMutableArray array];
                for (PreOrderMerchandise *model in self.model.goodsList) {
                    [photoArray addObject:model.SHOW_IMAGE_URL];
                }
                cell.imgUrlArray = photoArray;
                return cell;
            }
            break;
        }
        case 2:{
            LeftRightLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftRightLabelTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.hasArrow = NO;
            cell.leftLabel.text = self.titleArray[indexPath.row];
            cell.rightLabel.text = self.contentArray[indexPath.row];
            return cell;
            break;
        }
        case 3:{
            LeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftImageTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            PaymentModel *model = self.paymentStyleArray[indexPath.row];
            if ([model.transType isEqualToString:@"alipay"]) {
                cell.title = @"支付宝支付";
            }
            if ([model.transType isEqualToString:@"wxpay_public"]) {
                cell.title = @"微信支付";
            }
            if (indexPath.row == self.payment) {
                cell.selectImgView.image = [UIImage imageNamed:@"nick_select"];
            }else{
                cell.selectImgView.image = [UIImage imageNamed:@"nick_unselect"];
            }
            return cell;
            break;
        }
        case 4:{
            LeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftImageTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.title = self.payStyleArray[indexPath.row];
            if (indexPath.row + self.paymentStyleArray.count == self.payment) {
                cell.selectImgView.image = [UIImage imageNamed:@"nick_select"];
            }else{
                cell.selectImgView.image = [UIImage imageNamed:@"nick_unselect"];
            }
            return cell;
            break;
        }
        case 5:{
            BankSelectViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankSelectViewTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.selectBankModel;
//            cell.selectIMGV.image = [UIImage imageNamed:@"nick_select"];
            cell.selectIMGV.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        case 6:{
            LeftRightLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftRightLabelTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.hasArrow = YES;
            cell.leftLabel.text = @"发票类型";
            if (self.currentInvoiceModel != nil) {
                NSString *tempStr;
                if ([self.currentInvoiceModel.invoiceType isEqualToString:@"1"]) {
                    tempStr = @"个人";
                    cell.rightLabel.text = tempStr;
                }else{
                    tempStr = @"单位-";
                     cell.rightLabel.text =[tempStr stringByAppendingString:self.currentInvoiceModel.invoiceName];
                }
            }else{
                for (InvoiceModel *model in self.invoiceArray) {
                    if ([model.isDefault isEqualToString:@"1"]) {
                        self.currentInvoiceModel = model;
                        NSString *tempStr;
                        if ([self.currentInvoiceModel.invoiceType isEqualToString:@"1"]) {
                            tempStr = @"个人";
                            cell.rightLabel.text = tempStr;
                        }else{
                            tempStr = @"单位-";
                            cell.rightLabel.text =[tempStr stringByAppendingString:self.currentInvoiceModel.invoiceName];
                        }
                        
                        break;
                    }
                }
                if (self.currentInvoiceModel == nil) {
                    cell.rightLabel.text = @"点击选择发票";
                }
            }
            return cell;
            break;
        }
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3 || section == 4) {
        return 0;
    }
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = COLOR_RGB16(0xf5f5f5);
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if (self.userAddressArray.count == 0 || self.userAddressArray == nil) {
                AddAddressViewController *vc = [[AddAddressViewController alloc] init];
                [self.myViewController.navigationController pushViewController:vc animated:YES];
            }else{
                AddressManageViewController *vc = [[AddressManageViewController alloc] init];
                vc.shouldSelectBack = YES;
                vc.backAddressModel = ^(UserAddressModel *model) {
                    self.currentAddressModel = model;
                    [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                };
                
                [self.myViewController.navigationController pushViewController:vc animated:YES];
            }
            break;
        }
        case 1:{
            if (indexPath.row == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:0.7 animations:^{
                        self.datePicker.hidden = NO;
                        [self.maskView setHidden:NO];
                    }];
                });
            }else if (indexPath.row ==1){
                OrderMerchadiseLisetViewController *vc = [[OrderMerchadiseLisetViewController alloc] initWithList:self.model.goodsList];
                [self.myViewController.navigationController pushViewController:vc animated:YES];
            }
            break;
        }
        case 3:{
            self.payment = indexPath.row;
            self.selectBankModel = nil;
            [tableView reloadData];
            break;
        }
        case 4:{
            self.payment = indexPath.row + self.paymentStyleArray.count;
            if(indexPath.row == 1){
                [((MakeOrderViewController *)self.myViewController) getBankCardList];
            }else{
                self.selectBankModel = nil;
            }
            [tableView reloadData];
            break;
        }
        case 6:{
            ManageInvoiceViewController *vc = [[ManageInvoiceViewController alloc] initWithModel:self.currentInvoiceModel money:[NSString stringWithFormat:@"¥ %.2f",self.model.allPayPrice.floatValue] phoneNum:self.currentAddressModel.mobileNo];
            vc.selectInvoice = ^(InvoiceModel *model) {
                self.currentInvoiceModel = model;
                [self.mainTableView reloadData];
            };
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
}
//支付方式(1-微信2-支付宝3-余额支付4-线下打款)
- (void)toPay{
    if (self.payment == -1) {
        [Tool showMessage:@"请选择支付方式" duration:3];
        return;
    }
    NSString *cartId = [NSString stringWithFormat:@"%ld", self.model.cartId.integerValue];
    if (self.currentAddressModel == nil) {
        [Tool showMessage:@"请选择收货地址" duration:3];
        return;
    }
    NSString *addressId = [NSString stringWithFormat:@"%ld", self.currentAddressModel.addressId];
    NSString *collectId = [NSString stringWithFormat:@"%ld", self.selectBankModel.bankCardId.integerValue];
    NSInteger realPayment = -1;
    NSInteger tempCount = self.paymentStyleArray.count;
    if ((self.payment - tempCount + 1) > 0) {
        if (self.payment - self.paymentStyleArray.count + 1 == 1) {
            realPayment = 3;
        }
        if (self.payment - self.paymentStyleArray.count + 1 == 2) {
            realPayment = 4;
        }
    }else{
        PaymentModel *model = self.paymentStyleArray[self.payment];
        if ([model.transType isEqualToString:@"alipay"]) {
            realPayment = 2;
        }
        if ([model.transType isEqualToString:@"wxpay_public"]) {
             realPayment = 1;
        }
    }
    if (realPayment == 3) {
        UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
        if ([config.isPayPassword isEqualToString:@"2"]) {
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"请设置交易密码" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"以后" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *action_2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                SetPayPasswordViewController *vc = [[SetPayPasswordViewController alloc] init];
                [self.myViewController.navigationController pushViewController:vc animated:YES];
            }];
            [alertVC addAction:action_1];
            [alertVC addAction:action_2];
            [self.myViewController presentViewController:alertVC animated:YES completion:^{
                ;
            }];
        }else{
            [UIView animateWithDuration:0.7 animations:^{
                [self.inputPasswordView.passwordField becomeFirstResponder];
                self.inputPasswordView.hidden = NO;
                [self.maskView setHidden:NO];
            }];
        }
    }else{
    [((MakeOrderViewController *)self.myViewController) makeOrderWithCartId:cartId addressId:addressId invoiceId:[NSString stringWithFormat:@"%ld", self.currentInvoiceModel.invoiceId.integerValue] paymentWay:realPayment collectId:collectId deliveryTime:self.deliverTime];
    }
}

- (NSArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[@"下单商品金额",@"下单积分",@"小计"];
    }
    return _titleArray;
}

- (NSArray *)payStyleArray{
    if (!_payStyleArray) {
        _payStyleArray = @[@"余额", @"线下打款"];
    }
    return _payStyleArray;
}

- (void)setMerchandiseArray:(NSMutableArray<MerchandiseSelectResultModel *> *)merchandiseArray{
    _merchandiseArray = merchandiseArray;
    [self.mainTableView reloadData];
}

- (void)setModel:(PreOrderModel *)model{
    _model = model;
    self.contentArray = [NSMutableArray arrayWithArray: @[[NSString stringWithFormat:@"¥ %.2f",model.allPrice.floatValue],
                                                          [NSString stringWithFormat:@" %ld积分",model.point.integerValue],
                                                          [NSString stringWithFormat:@"¥ %.2f",model.allPayPrice.floatValue]]];
    self.shouldPayLabel.text = [NSString stringWithFormat:@"应支付: %.2f 元",model.allPayPrice.floatValue];
    [self.mainTableView reloadData];
}

- (void)setBankArray:(NSArray *)bankArray{
    _bankArray = bankArray;
    self.bankSelectView.bankArray = bankArray;
    [self.bankSelectView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44 + 60 * bankArray.count);
    }];
    [UIView animateWithDuration:0.7 animations:^{
        self.bankSelectView.hidden = NO;
        [self.maskView setHidden:NO];
    }];
}

- (void)setInvoiceArray:(NSArray *)invoiceArray{
    _invoiceArray = [NSArray arrayWithArray:invoiceArray];
    [self.mainTableView reloadData];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (void)setPaymentStyleArray:(NSArray *)paymentStyleArray{
    _paymentStyleArray = [NSArray arrayWithArray:paymentStyleArray];
    [self.mainTableView reloadData];
}
@end
