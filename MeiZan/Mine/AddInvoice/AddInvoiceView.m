//
//  AddInvoiceView.m
//  JingXuan
//
//  Created by sfs on 2017/12/18.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "AddInvoiceView.h"
#import "AddInvoiceTableViewCell.h"
#import "AddInvoiceView.h"
#import "AddInvoiceViewController.h"
@interface AddInvoiceView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, assign) NSInteger selectIndex;//1个人 2公司
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic ,strong) AddInvoiceTableViewCell *cell;
@end
@implementation AddInvoiceView
- (void)configInitial{
    self.selectIndex = 0;
}
- (void)createSubview{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[AddInvoiceTableViewCell class] forCellReuseIdentifier:@"AddInvoiceTableViewCell"];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.trailing.mas_equalTo(self);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWillShow:(NSNotification *)aNotification

{
    NSDictionary *userInfo = [aNotification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    int height = keyboardRect.size.height;
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self).offset(-height);
        }];
        [self layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)aNotification{
    NSDictionary *userInfo = [aNotification userInfo];
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];

    [UIView animateWithDuration:duration.doubleValue animations:^{
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self);
        }];
        [self layoutIfNeeded];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 710;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddInvoiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddInvoiceTableViewCell"];
    self.cell = cell;
    if (self.selectIndex == 1) {
        [cell.titleTypeButton_person setTitleColor:STYLECOLOR forState:UIControlStateNormal];
        cell.titleTypeButton_person.layer.borderColor = STYLECOLOR.CGColor;
        [cell.titleTypeButton_company setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
        cell.titleTypeButton_company.layer.borderColor = TEXTCOLOR.CGColor;
        cell.const_titleMsg.text = @"个人";
        cell.companyName.hidden = YES;
        cell.USCCNumberTextField.userInteractionEnabled = NO;
        cell.USCCNumberTextField.text = @"无需填写";
    }else if(self.selectIndex == 2){
        [cell.titleTypeButton_person setTitleColor:TEXTCOLOR forState:UIControlStateNormal];
        [cell.titleTypeButton_company setTitleColor:STYLECOLOR forState:UIControlStateNormal];
        cell.titleTypeButton_person.layer.borderColor = TEXTCOLOR.CGColor;
        cell.titleTypeButton_company.layer.borderColor = STYLECOLOR.CGColor;
        cell.const_titleMsg.text = @"单位";
        cell.USCCNumberTextField.userInteractionEnabled = YES;
        cell.USCCNumberTextField.text = @"";
        cell.companyName.hidden = NO;
    }
    [cell.saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.titleTypeButton_person addTarget:self action:@selector(selectPerson:) forControlEvents:UIControlEventTouchUpInside];
    [cell.titleTypeButton_company addTarget:self action:@selector(selectCompany:) forControlEvents:UIControlEventTouchUpInside];
    cell.invoicePhoneNumber.text = self.phoneNumber;
    cell.invoiceMoney.text = self.money;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)selectPerson:(UIButton *)sender{
    self.selectIndex = 1;
    [self.tableView reloadData];
}

- (void)selectCompany:(UIButton *)sender{
    self.selectIndex = 2;
    [self.tableView reloadData];
}

- (void)saveAction:(UIButton *)button{
    NSString *invoiceName;
    if (self.selectIndex == 1) {
        invoiceName = @"个人";
        if (self.cell.invoiceContent.text.length == 0 || self.cell.invoiceContent.text== nil) {
            [Tool showMessage:@"请输入发票内容" duration:3];
            return;
        }
    }else{
        if (self.cell.companyName.text.length == 0 || self.cell.companyName.text== nil) {
            [Tool showMessage:@"请输入单位名称" duration:3];
            return;
        }
        if (self.cell.USCCNumberTextField.text.length == 0 || self.cell.USCCNumberTextField.text== nil) {
            [Tool showMessage:@"请输入纳税人识别号" duration:3];
            return;
        }
        if (self.cell.invoiceContent.text.length == 0 || self.cell.invoiceContent.text== nil) {
            [Tool showMessage:@"请输入发票内容" duration:3];
            return;
        }
        invoiceName = self.cell.companyName.text;
    }
    [((AddInvoiceViewController *)self.myViewController) uploadInvoiceWithId:@"" invoiceName:invoiceName invoiceType:[NSString stringWithFormat:@"%ld",self.selectIndex] identifyNumber:self.cell.USCCNumberTextField.text isDefault:@"0" content:self.cell.invoiceContent.text];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (![[super hitTest:point withEvent:event] isKindOfClass:[UITextField class]]) {
        [self endEditing:YES];;
    }
    return [super hitTest:point withEvent:event];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
