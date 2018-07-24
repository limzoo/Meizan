//
//  AddInvoiceTableViewCell.m
//  JingXuan
//
//  Created by sfs on 2017/12/18.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "AddInvoiceTableViewCell.h"
@interface AddInvoiceTableViewCell()
@end
@implementation AddInvoiceTableViewCell
- (void)createSubview{
    UILabel *const_invoiceType = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:COLOR_RGB16(0x999999) text:@"发票类型"];
    [self.contentView addSubview:const_invoiceType];
    [const_invoiceType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(16));
    }];
    
    UILabel *invoiceType = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:TEXTCOLOR text:@"纸质普通发票"];
    [self.contentView addSubview:invoiceType];
    [invoiceType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(const_invoiceType.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(16));
    }];
    
    UIView *inset_lineView = [[UIView alloc] init];
    inset_lineView.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:inset_lineView];
    [inset_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(const_invoiceType.mas_bottom).offset(15);
        make.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *announceLabel = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:@"电子普通发票是税局认可的有效凭证，其法律效力、基本用途及使用规则同纸质发票"];
    announceLabel.numberOfLines = 2;
    [self.contentView addSubview:announceLabel];
    [announceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(inset_lineView.mas_bottom).offset(17);
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(17));
    }];
    
    UIView *inset_lineView2 = [[UIView alloc] init];
    inset_lineView2.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:inset_lineView2];
    [inset_lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.height.mas_equalTo(8);
        make.top.mas_equalTo(announceLabel.mas_bottom).offset(17);
    }];
    
    UILabel *const_title = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:COLOR_RGB16(0x999999) text:@"*发票抬头"];
    [self.contentView addSubview:const_title];
    [const_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(inset_lineView2.mas_bottom).offset(16);
    }];
    
    self.titleTypeButton_person = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@"个人"];
    self. titleTypeButton_person.layer.borderColor = COLOR_RGB16(0x979797).CGColor;
    self.titleTypeButton_person.layer.borderWidth = 0.5;
    [self.contentView addSubview:self.titleTypeButton_person];
    [self.titleTypeButton_person mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(60));
        make.height.mas_equalTo(32);
        make.centerY.mas_equalTo(const_title.mas_centerY);
        make.leading.mas_equalTo(const_title.mas_trailing).offset(CUSTOM_WIDTH(16));
    }];
    
    self.titleTypeButton_company = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:14 title:@"单位"];
    self.titleTypeButton_company.layer.borderColor = COLOR_RGB16(0x979797).CGColor;
    self.titleTypeButton_company.layer.borderWidth = 0.5;
    [self.contentView addSubview: self.titleTypeButton_company];
    [ self.titleTypeButton_company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CUSTOM_WIDTH(60));
        make.height.mas_equalTo(32);
        make.centerY.mas_equalTo(const_title.mas_centerY);
        make.leading.mas_equalTo( self.titleTypeButton_person.mas_trailing).offset(CUSTOM_WIDTH(14));
    }];
    
    UIView *inset_lineView3 = [[UIView alloc] init];
    inset_lineView3.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:inset_lineView3];
    [inset_lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(const_title.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(1);
    }];
    
    self.const_titleMsg = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:COLOR_RGB16(0x999999) text:@"个人"];
    self.const_titleMsg.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.const_titleMsg];
    [self.const_titleMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(inset_lineView3.mas_bottom).offset(16);
    }];
    
    
    self.companyName = [[UITextField alloc] init];
    self.companyName.hidden = YES;
        self.companyName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入单位名称" attributes:@{NSForegroundColorAttributeName:COLOR_RGB16(0x9b9b9b)}];
    [self.contentView addSubview:self.companyName];
    self.companyName.textAlignment = NSTextAlignmentRight;
    [self.companyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.const_titleMsg);
        make.leading.mas_equalTo(self.const_titleMsg.mas_trailing).offset(CUSTOM_WIDTH(10));
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
    }];
    
    UIView *inset_lineView4 = [[UIView alloc] init];
    inset_lineView4.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:inset_lineView4];
    [inset_lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.const_titleMsg.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *const_USCCNumber = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:16] color:COLOR_RGB16(0x999999) text:@"纳税人识别号"];
    [self.contentView addSubview:const_USCCNumber];
    [const_USCCNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(inset_lineView4).offset(16);
        
    }];
    
    self.USCCNumberTextField = [[UITextField alloc] init];
    [self.contentView addSubview:self.USCCNumberTextField];
    self.USCCNumberTextField.textAlignment = NSTextAlignmentRight;
    self.USCCNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入纳税人识别号" attributes:@{NSForegroundColorAttributeName:COLOR_RGB16(0x9b9b9b)}];
    [self.USCCNumberTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(const_USCCNumber.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(const_USCCNumber);;
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(14));
    }];
    
    UIView *inset_lineView5 = [[UIView alloc] init];
    inset_lineView5.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:inset_lineView5];
    [inset_lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.USCCNumberTextField.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *const_invoiceContent = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:16] color:COLOR_RGB16(0x999999) text:@"*发票内容"];
    [self.contentView addSubview:const_invoiceContent];
    [const_invoiceContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(inset_lineView5.mas_bottom).offset(16);
    }];
    
    self.invoiceContent = [[UITextField alloc] init];
    self.invoiceContent.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.invoiceContent];
    self.invoiceContent.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入发票内容" attributes:@{NSForegroundColorAttributeName:COLOR_RGB16(0x9b9b9b)}];
    [self.invoiceContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(const_invoiceContent.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.centerY.mas_equalTo(const_invoiceContent);
        make.trailing.mas_equalTo(self).offset(-CUSTOM_WIDTH(14));
    }];
    
    UIView *inset_lineView6 = [[UIView alloc] init];
    inset_lineView6.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:inset_lineView6];
    [inset_lineView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(const_invoiceContent.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *const_money = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:16] color:COLOR_RGB16(0x999999) text:@"发票金额"];
    [self.contentView addSubview:const_money];
    [const_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(inset_lineView6.mas_bottom).offset(16);
    }];
    
    self.invoiceMoney = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:16] color:TEXTCOLOR text:@""];
    [self.contentView addSubview: self.invoiceMoney];
    [ self.invoiceMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(const_money);
        make.leading.mas_equalTo(const_money.mas_trailing).offset(CUSTOM_WIDTH(14));
    }];
    
    UIView *inset_lineView7 = [[UIView alloc] init];
    inset_lineView7.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:inset_lineView7];
    [inset_lineView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(const_money.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *const_mobile = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:16] color:COLOR_RGB16(0x999999) text:@"*发票人手机"];
    [self.contentView addSubview:const_mobile];
    [const_mobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(inset_lineView7.mas_bottom).offset(16);
    }];
    
    self.invoicePhoneNumber = [UILabel initWithCustomFontOfSize:[UIFont fontWithName:@"PingFangSC-Regular" size:16] color:TEXTCOLOR text:@""];
    [self.contentView addSubview: self.invoicePhoneNumber];
    [ self.invoicePhoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(const_mobile);
        make.leading.mas_equalTo(const_mobile.mas_trailing).offset(CUSTOM_WIDTH(14));
    }];
    
    UIView *inset_lineView8 = [[UIView alloc] init];
    inset_lineView8.backgroundColor = INSETCOLOR_F5;
    [self.contentView addSubview:inset_lineView8];
    [inset_lineView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self.contentView);
        make.top.mas_equalTo(const_mobile.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(1);
    }];
    
    self.saveButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4 fontSize:16 title:@"保存"];
    [self.contentView addSubview:self.saveButton];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView);
        make.top.mas_equalTo(inset_lineView8.mas_bottom).offset(13);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(CUSTOM_WIDTH(343));
    }];
    
    UILabel *announceLabel2 = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:12] color:TEXTCOLOR text:nil];
    announceLabel2.numberOfLines = 0;
    announceLabel2.text = @"发票须知：\n1、发票金额为用户实际支付的金额（不含礼品卡与不支持该发票类型的商品实付金额）\n2、电子发票可在确认收货后，在“订单详情页”下载\n3、未随箱寄出的纸质发票会在发货后15～30个工作日单独寄出\n4、单笔订单只支持开具一种类型的发票\n5、年购订单发票随每期子单寄出";
    [self.contentView addSubview:announceLabel2];
    [announceLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.contentView).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(self.contentView).offset(-CUSTOM_WIDTH(18));
        make.top.mas_equalTo(self.saveButton.mas_bottom).offset(20);
    }];
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
