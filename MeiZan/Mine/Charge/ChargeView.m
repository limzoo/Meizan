//
//  ChargeView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ChargeView.h"
#import "PayStyleSelectTableViewCell.h"
#import "ChargeViewController.h"
#import "BankSelectViewTableViewCell.h"
#import "BankSelectView.h"
#import "PaymentModel.h"
@interface ChargeView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITextField *chargeTextField;
@property (nonatomic, strong) UITableView *pageStyleSelectTableView;
@property (nonatomic, strong) NSArray *payStyleArray;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) UIView *maskView;//遮罩层
@property (nonatomic, strong) BankSelectView *bankSelectView;
@property (nonatomic, assign) NSInteger selectType;
@end
@implementation ChargeView
- (void)configInitial{
    self.selectIndex = -1;
}
- (void)createSubview{
    self.backgroundColor = COLOR_RGB16(0xfafafa);
    
    self.maskView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.frame];
    [[UIApplication sharedApplication].keyWindow addSubview:self.maskView];
    self.maskView.backgroundColor =  [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5/1.0];
    self.maskView.hidden = YES;
    [self.maskView addSubview:self.bankSelectView];
    [self.bankSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.maskView);
        make.height.mas_equalTo(0);
    }];
    
    self.bankSelectView = [[BankSelectView alloc] init];
    [self.maskView addSubview:self.bankSelectView];
    __weak typeof(self) weakSelf = self;
    self.bankSelectView.cancelButtonAction = ^{
        [weakSelf bankSelectViewCancelAction];
    };
    
    self.bankSelectView.ensureButtonAction = ^(NSInteger index) {
        [weakSelf bankSelectViewEnsureAction:index];
    };
    self.bankSelectView.hidden = YES;
    [self.bankSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.maskView);
        make.height.mas_equalTo(0);
    }];
    
    UIView *textFieldView = [[UIView alloc] init];
    textFieldView.backgroundColor = [UIColor whiteColor];
    [self addSubview:textFieldView];
    [textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(20);
        make.height.mas_equalTo(80);
    }];
    
    UILabel *yuanLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"SourceHanSans-Regular" size:20] color:TITLECOLOR text:@"¥"];
    [textFieldView addSubview:yuanLabel];
    [yuanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(textFieldView);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(20);
    }];
    
    self.chargeTextField = [[UITextField alloc] init];
    self.chargeTextField.font = [UIFont fontWithName:@"PingFangSC-Regular" size:40];
    self.chargeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.chargeTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.chargeTextField.textAlignment = NSTextAlignmentLeft;
    NSAttributedString *placeHolderStr = [[NSAttributedString alloc] initWithString:@"请输入充值金额" attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:16],NSForegroundColorAttributeName:COLOR_RGB16(0x999999)}];
    self.chargeTextField.attributedPlaceholder  = placeHolderStr;
    [textFieldView addSubview:self.chargeTextField];
    [self.chargeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(textFieldView);
        make.leading.mas_equalTo(yuanLabel.mas_trailing).offset(10);
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
    }];
    
    UILabel *const_selectPayStyle = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:14] color:COLOR_RGB16(0x999999) text:@"请选择支付方式"];
    [self addSubview:const_selectPayStyle];
    [const_selectPayStyle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(textFieldView.mas_bottom).offset(14);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(100);
    }];
    
    self.pageStyleSelectTableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.pageStyleSelectTableView.scrollEnabled = NO;
    self.pageStyleSelectTableView.delegate = self;
    self.pageStyleSelectTableView.dataSource = self;
    [self.pageStyleSelectTableView registerClass:[PayStyleSelectTableViewCell class] forCellReuseIdentifier:@"PayStyleSelectTableViewCell"];
   [self.pageStyleSelectTableView registerClass:[BankSelectViewTableViewCell class] forCellReuseIdentifier:@"BankSelectViewTableViewCell"];
    [self addSubview:self.pageStyleSelectTableView];
    [self.pageStyleSelectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(const_selectPayStyle.mas_bottom).offset(14);
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(61);
    }];
    
    UIButton *toCharge = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4.0f fontSize:16 title:@"确定充值"];
    [toCharge addTarget:self action:@selector(chargeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:toCharge];
    [toCharge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.pageStyleSelectTableView.mas_bottom).offset(20);
    }];
    
     [self bringSubviewToFront:self.bankSelectView];
}


- (void)bankSelectViewEnsureAction:(NSInteger)index{
    [UIView animateWithDuration:0.7 animations:^{
        self.currentBankModel = self.bankArray[index];
        self.maskView.hidden = YES;
        self.bankSelectView.hidden = YES;
        [self.pageStyleSelectTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo((self.paymentStyleArray.count + self.payStyleArray.count + 1) * 61);
        }];
    } completion:^(BOOL finished) {
        if (finished) {
            [self.pageStyleSelectTableView reloadData];
        }
    }];
}

- (void)bankSelectViewCancelAction{
    [UIView animateWithDuration:0.7 animations:^{
        self.maskView.hidden = YES;
        self.bankSelectView.hidden = YES;
    }];
}

- (void)chargeAction:(UIButton *)button{
    if (self.selectIndex == -1) {
        [Tool showMessage:@"请选择充值方式" duration:3];
        return;
    }
    if (self.chargeTextField.text.length == 0) {
        [Tool showMessage:@"请输入充值金额" duration:3];
        return;
    }
    if (self.chargeTextField.text.intValue == 0) {
        [Tool showMessage:@"充值金额不能为0" duration:3];
        return;
    }
    NSInteger realPayment = -1;
    NSInteger tempCount = self.paymentStyleArray.count;
    if ((self.selectIndex - tempCount + 1) > 0) {
        if (self.selectIndex - self.paymentStyleArray.count + 1 == 1) {
            realPayment = 3;
        }
        if (self.selectIndex - self.paymentStyleArray.count + 1 == 2) {
            realPayment = 4;
        }
    }else{
        PaymentModel *model = self.paymentStyleArray[self.selectIndex];
        if ([model.transType isEqualToString:@"alipay"]) {
            realPayment = 2;
        }
        if ([model.transType isEqualToString:@"wxpay_public"]) {
            realPayment = 1;
        }
    }
    [((ChargeViewController *)self.myViewController) chargeWithType:realPayment withChargeNum:self.chargeTextField.text.floatValue];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.paymentStyleArray.count;
    }
    else if (section == 1) {
        return self.payStyleArray.count;
    }else if (section == 2){
        if (self.currentBankModel) {
            return 1;
        }else{
            [self.pageStyleSelectTableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo((self.paymentStyleArray.count + self.payStyleArray.count) * 61);
            }];
            return 0;
        }
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PayStyleSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayStyleSelectTableViewCell"];
        PaymentModel *model = self.paymentStyleArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([model.transType isEqualToString:@"alipay"]) {
            cell.titleText = @"支付宝支付";
        }
        if ([model.transType isEqualToString:@"wxpay_public"]) {
            cell.titleText = @"微信支付";
        }
        if (self.selectIndex == indexPath.row) {
            cell.isSelected = YES;
        }else{
            cell.isSelected = NO;
        }
        return cell;
    }else if (indexPath.section == 1) {
        PayStyleSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayStyleSelectTableViewCell"];
        cell.titleText = self.payStyleArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row  == self.selectIndex - self.paymentStyleArray.count) {
            cell.isSelected = YES;
        }else{
            cell.isSelected = NO;
        }
        return cell;
    }else{
        BankSelectViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankSelectViewTableViewCell"];
        cell.model = self.currentBankModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.selectIMGV.image = [UIImage imageNamed:@"nick_select"];
        return cell;
    }
    return nil;
}
//1支付宝 2微信 3线下打款
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        self.selectIndex = indexPath.row;
        PaymentModel *model = self.paymentStyleArray[indexPath.row];
        if ([model.transType isEqualToString:@"wxpay_public"]) {
            self.selectType = 2;
        }else  if ([model.transType isEqualToString:@"alipay"]){
            self.selectType = 1;
        }
         self.currentBankModel = nil;
        [self.pageStyleSelectTableView reloadData];
    }
    if (indexPath.section == 1) {
        self.selectIndex = indexPath.row + self.paymentStyleArray.count;
        if (indexPath.row == 0) {
            [((ChargeViewController *)self.myViewController) getBankCardList];
            self.selectType = 3;
        }else{
            self.currentBankModel = nil;
        }
        [self.pageStyleSelectTableView reloadData];
    }
}
- (NSArray *)payStyleArray{
    if (!_payStyleArray) {
        _payStyleArray = @[@"线下打款"];
    }
    return _payStyleArray;
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
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.maskView.hidden == NO && ![Tool isPoint:point inFrame:self.bankSelectView.frame]) {
        self.maskView.hidden = YES;
    }
    if (![Tool isPoint:point inFrame:self.chargeTextField.frame]) {
        [self.chargeTextField resignFirstResponder];
    }

    return [super hitTest:point withEvent:event];
}

- (void)setPaymentStyleArray:(NSMutableArray *)paymentStyleArray{
    _paymentStyleArray = [NSMutableArray arrayWithArray: paymentStyleArray];
    [self.pageStyleSelectTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((_paymentStyleArray.count + 1) * 61);
    }];
    [self layoutIfNeeded];
    [self.pageStyleSelectTableView reloadData];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
