//
//  SelectPayStyleView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "SelectPayStyleView.h"
#import "LeftImageTableViewCell.h"
#import "NextStepTableViewCell.h"
#import "SelectPayStyleViewController.h"
#import "SetPayPasswordViewController.h"
#import "PaymentModel.h"
#import "BankModel.h"
#import "BankSelectView.h"
#import "BankSelectViewTableViewCell.h"
@interface SelectPayStyleView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger payment;
@property (nonatomic, strong) BankModel *selectBankModel;
@property (nonatomic, strong) BankSelectView *bankSelectView;

//遮罩层
@end
@implementation SelectPayStyleView
- (void)configInitial{
    self.payment = -1;
}
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    self.maskView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    self.maskView.backgroundColor =  [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5/1.0];
    self.maskView.hidden = YES;
    
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
    
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[LeftImageTableViewCell class] forCellReuseIdentifier:@"LeftImageTableViewCell"];
    [self.tableView registerClass:[BankSelectViewTableViewCell class] forCellReuseIdentifier:@"BankSelectViewTableViewCell"];
    [self addSubview: self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(61 * 2);
    }];
    
    UIButton *payButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4 fontSize:16 title:@"支付"];
    [payButton addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:payButton];
    [payButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(10);
    }];
    
    self.inputPasswordView = [[InputPasswordView alloc] init];
    self.inputPasswordView.backgroundColor = [UIColor whiteColor];
    self.inputPasswordView.hidden = YES;
    [self.inputPasswordView.cancelButton addTarget:self action:@selector(cancelInput:) forControlEvents:UIControlEventTouchUpInside];
    [self.maskView addSubview:self.inputPasswordView];
    [self.inputPasswordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.maskView);
        make.height.mas_equalTo(380);
    }];
    self.inputPasswordView.verifyPayPassword = ^(NSString *password) {
        [((SelectPayStyleViewController *)weakSelf.myViewController) verifyPayPassword:password];
    };
}

- (void)bankSelectViewEnsureAction:(NSInteger)index{
    [UIView animateWithDuration:0.7 animations:^{
        self.selectBankModel = self.bankArray[index];
        self.maskView.hidden = YES;
        self.bankSelectView.hidden = YES;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo((self.paymentArray.count + 3) * 61);
            }];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return self.paymentArray.count;
            break;
        case 1:
            return 2;
            break;
        case 2:
            if (self.selectBankModel) {
                return 1;
            }else{
                return 0;
            }
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            LeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftImageTableViewCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            PaymentModel *model = self.paymentArray[indexPath.row];
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
        case 1:{
            switch (indexPath.row) {
                case 0:{
                    LeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftImageTableViewCell" forIndexPath:indexPath];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.title = @"余额";
                    if (indexPath.row + self.paymentArray.count == self.payment) {
                        cell.selectImgView.image = [UIImage imageNamed:@"nick_select"];
                    }else{
                        cell.selectImgView.image = [UIImage imageNamed:@"nick_unselect"];
                    }
                    return cell;
                    break;
                }
                    
                case 1:{
                    LeftImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftImageTableViewCell" forIndexPath:indexPath];
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.title = @"线下打款";
                    if (indexPath.row + self.paymentArray.count == self.payment) {
                        cell.selectImgView.image = [UIImage imageNamed:@"nick_select"];
                    }else{
                        cell.selectImgView.image = [UIImage imageNamed:@"nick_unselect"];
                    }
                    return cell;
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 2:{
            BankSelectViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankSelectViewTableViewCell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.selectBankModel;
            //            cell.selectIMGV.image = [UIImage imageNamed:@"nick_select"];
            cell.selectIMGV.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            break;
        }
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            self.payment = indexPath.row;
            [tableView reloadData];
            break;
        }
        case 1:{
            self.payment = indexPath.row + self.paymentArray.count;
            if(indexPath.row == 1){
                [((SelectPayStyleViewController *)self.myViewController) getBankCardList];
            }else{
                
                [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo((self.paymentArray.count + 2) * 61);
                }];
                self.selectBankModel = nil;
            }
            [tableView reloadData];
            break;
        }
            
        default:
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}
- (void)toPay{
    if (self.payment == -1) {
        [Tool showMessage:@"请选择支付方式" duration:3];
        return;
    }
    NSInteger realPayment = -1;
    NSInteger paymentArrayCount = self.paymentArray.count;
    if (self.payment > paymentArrayCount - 1) {
        if (self.payment - self.paymentArray.count + 1 == 1) {
            realPayment = 3;
        }
        if (self.payment - self.paymentArray.count + 1 == 2) {
            realPayment = 4;
        }
    }else{
        PaymentModel *model = self.paymentArray[self.payment];
        if ([model.transType isEqualToString:@"alipay"]) {
            realPayment = 2;
        }
        if ([model.transType isEqualToString:@"wxpay_public"]) {
            realPayment = 1;
        }
    }
    if (realPayment == 3) {
        UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
        if (!config.isPayPassword) {
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
    [((SelectPayStyleViewController *)self.myViewController) payWithPayType:realPayment];
    }
}

- (void)setPaymentArray:(NSArray *)paymentArray{
    _paymentArray = [NSArray arrayWithArray:paymentArray];
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((paymentArray.count + 2) * 61);
    }];
    [self.tableView reloadData];
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
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
