//
//  AddAddress.m
//  JingXuan
//
//  Created by sfs on 2017/12/15.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "AddAddress.h"
#import "AddAddressTableViewCell.h"
#import "LMSelectorViewController.h"
#import "AddAddressViewController.h"
@interface AddAddress()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, LMSelectorDelegate>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) UIButton *setDefaultAddressButton;
@property (nonatomic, strong) UIButton *completeButton;
@property (nonatomic, strong) NSMutableArray *placeHolderArray;
@property (nonatomic, strong) NSArray *imgTitleArray;

@property (nonatomic, strong) UIView *masksView;
@property (nonatomic, strong) UIView *selectView;

@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) LMSelectorViewController *vc;

@property (nonatomic, strong) NSMutableArray *contentArray;
@end
@implementation AddAddress
- (void)configInitial{
    [self.dataDic setObject:@"0" forKey:@"isDefault"];
    self.backgroundColor = [UIColor whiteColor];
    self.placeHolderArray = [NSMutableArray arrayWithArray: @[@"收货人姓名",@"收货人的电话",@"选择所在地区",@"请输入街道、门牌等详细资质信息"]];
}
- (void)createSubview{
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.scrollEnabled = NO;
    [self.mainTableView registerClass:[AddAddressTableViewCell class] forCellReuseIdentifier:@"AddAddressTableViewCell"];
    [self addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(240);
    }];
    
    self.setDefaultAddressButton = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@"设为默认地址"];
    [self.setDefaultAddressButton setImage:[UIImage imageNamed:@"nick_unselect"] forState:UIControlStateNormal];
    self.setDefaultAddressButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [self.setDefaultAddressButton addTarget:self action:@selector(setAddressDefault:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.setDefaultAddressButton];
    [self.setDefaultAddressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(120));
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.mainTableView.mas_bottom).offset(20);
    }];
    
    self.completeButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4 fontSize:16 title:@"完成"];
    [self.completeButton addTarget:self action:@selector(uploadAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.completeButton];
    [self.completeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(CUSTOM_WIDTH(344));
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.setDefaultAddressButton.mas_bottom).offset(20);
    }];
    
    self.masksView = [[UIView alloc] init];
    self.masksView.hidden = YES;
    self.masksView.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5/1.0];
    [self addSubview:self.masksView];
    [self.masksView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.mas_equalTo(self);
    }];
    
    self.selectView = [[UIView alloc] init];
    self.selectView.backgroundColor = [UIColor whiteColor];
    [self.masksView addSubview:self.selectView];
    [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(360);
    }];
    
    self.vc = [[LMSelectorViewController alloc] init];
    [self.myViewController addChildViewController:self.vc];
    self.vc.delegate = self;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddAddressTableViewCell"];
    cell.iconIMGV.image = [UIImage imageNamed:self.imgTitleArray[indexPath.row]];
    cell.iconIMGV.contentMode = UIViewContentModeScaleAspectFill;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self.placeHolderArray[indexPath.row] attributes:@{NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:14],NSForegroundColorAttributeName:COLOR_RGB16(0x999999)}];
    cell.inputTextField.attributedPlaceholder = str;
    [cell.inputTextField addTarget:self action:@selector(inputTextFieldValueChange:) forControlEvents:UIControlEventEditingChanged];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 2) {
        cell.hasArrow = YES;
    }else{
        cell.hasArrow = NO;
    }
    if (indexPath.row == 1) {
        cell.inputTextField.keyboardType = UIKeyboardTypeNumberPad;
    }else{
        cell.inputTextField.keyboardType = UIKeyboardTypeDefault;
    }
    cell.inputTextField.delegate = self;
    cell.inputTextField.tag = indexPath.row;
    if (self.contentArray) {
        cell.inputTextField.text = self.contentArray[indexPath.row];
    }
    return cell;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 2) {
        [self showSelectAddressPage];
        return NO;
    }
    return YES;
}

- (void)showSelectAddressPage{
    [self endEditing:YES];
    [self.vc.view setFrame:self.selectView.bounds];
    [self.selectView addSubview:self.vc.view];
    
    [UIView animateWithDuration:0.7 animations:^{
        self.masksView.hidden = NO;
    }];
}
/*isDefault    string    是    是否默认收货地址(0-否;1-是)        1
 consignee    string    是    收货人姓名        龙俊奇
 mobileNo    string    是    电话号码        13423732017
 province    string    是    省        广东
 city    string    是    市        深圳
 district    string    是    区        宝安区
 address    */
- (void)selector:(LMSelectorViewController *)selector didFinishSelectWithProvince:(NSString *)province city:(NSString *)city district:(NSString *)district{
    [self.dataDic setObject:province forKey:@"province"];
    self.model.province = province;
    [self.dataDic setObject:city forKey:@"city"];
    self.model.city =city;
    [self.dataDic setObject:district forKey:@"district"];
    self.model.district = district;
    NSString *result = [[province stringByAppendingString:city] stringByAppendingString:district];
    if (self.model) {
        [self.contentArray setObject:result atIndexedSubscript:2];
    }
    [self.placeHolderArray setObject:result atIndexedSubscript:2];
    [self.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [UIView animateWithDuration:0.7 animations:^{
        self.masksView.hidden = YES;
    }];
}

- (void)selector:(LMSelectorViewController *)selector didNotFinishSelectAddIndex:(NSUInteger)currentIndex{
    [UIView animateWithDuration:0.7 animations:^{
        self.masksView.hidden = YES;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.contentArray setObject:@"" atIndexedSubscript:2];
            [self.mainTableView reloadData];
        }
    }];
}

- (void)inputTextFieldValueChange:(UITextField *)textField{
    switch (textField.tag) {
        case 0:
            [self.dataDic setObject:textField.text forKey:@"consignee"];
            if (self.model) {
                [self.contentArray setObject:textField.text atIndexedSubscript:0];
            }
            break;
        case 1:
            [self.dataDic setObject:textField.text forKey:@"mobileNo"];
            if (self.model) {
                [self.contentArray setObject:textField.text atIndexedSubscript:1];
            }
            break;
        case 3:
            [self.dataDic setObject:textField.text forKey:@"address"];
            if (self.model) {
                [self.contentArray setObject:textField.text atIndexedSubscript:3];
            }
            break;
        default:
            break;
    }
}

- (NSArray *)imgTitleArray{
    if (!_imgTitleArray) {
        _imgTitleArray = @[@"nickname_unselect",@"mobile_unselect",@"location_gray",@"location_gray"];
    }
    return _imgTitleArray;
}

- (NSMutableDictionary *)dataDic{
    if (!_dataDic) {
        _dataDic = [NSMutableDictionary dictionary];
    }
    return _dataDic;
}

- (void)setAddressDefault:(UIButton *)button{
    //    if (![self.dataDic objectForKey:@"isDefault"]) {
    //        [self.dataDic setObject:@"1" forKey:@"isDefault"];
    //        [button setImage:[UIImage imageNamed:@"nick_select"] forState:UIControlStateNormal];
    //    }else{
    NSString *str = [self.dataDic objectForKey:@"isDefault"];
    [self.dataDic setObject:[NSString stringWithFormat:@"%d",!str.boolValue] forKey:@"isDefault"];
    if (!(str.boolValue)) {
        [button setImage:[UIImage imageNamed:@"nick_select"] forState:UIControlStateNormal];
    }else{
        [button setImage:[UIImage imageNamed:@"nick_unselect"] forState:UIControlStateNormal];
    }
    //    }
}
- (void)uploadAddress:(UIButton *)sender{
    if (![self.dataDic objectForKey:@"consignee"]) {
        [Tool showMessage:@"请输入收件人姓名" duration:3];
        return;
    }
    if (![self.dataDic objectForKey:@"mobileNo"]) {
        [Tool showMessage:@"请输入收件人手机号码" duration:3];
        return;
    }
    if (![self.dataDic objectForKey:@"address"]) {
        [Tool showMessage:@"请输入详细收件地址" duration:3];
        return;
    }
    if (![self.dataDic objectForKey:@"city"]) {
        [Tool showMessage:@"请选择收件区域" duration:3];
        return;
    }
    [((AddAddressViewController *)self.myViewController) addAddressWithDataDic:self.dataDic];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    [self endEditing:YES];
    if (self.maskView.hidden == NO && ![Tool isPoint:point inFrame:self.selectView.frame]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.masksView.hidden = YES;
        });
    }
    return [super hitTest:point withEvent:event];
}

- (void)setModel:(UserAddressModel *)model{
    _model = model;
    [self.dataDic setObject:[NSNumber numberWithLong:model.addressId] forKey:@"id"];
    if (self.model.isDefault.intValue == 1) {
        [self.dataDic setObject:@"1" forKey:@"isDefault"];
        [self.setDefaultAddressButton setImage:[UIImage imageNamed:@"nick_select"] forState:UIControlStateNormal];
    }else{
        [self.setDefaultAddressButton setImage:[UIImage imageNamed:@"nick_unselect"] forState:UIControlStateNormal];
    }
    self.contentArray =[NSMutableArray arrayWithArray: @[self.model.consignee,self.model.mobileNo,[[model.province stringByAppendingString:model.city] stringByAppendingString:model.district],self.model.address]];
    self.dataDic = [model yy_modelToJSONObject];
    [self.mainTableView reloadData];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
