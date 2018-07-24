//
//  VerifyUserViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/30.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "VerifyUserViewController.h"
#import "SetPayPasswordViewController.h"
@interface VerifyUserViewController ()
@property (nonatomic, strong) UITextField *phoneNumber;
@property (nonatomic, strong) UITextField *verify;
@property (nonatomic, strong) UIButton *verifyButton;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger sec;
@end

@implementation VerifyUserViewController
- (void)viewWillAppear:(BOOL)animated{
    self.title = @"校验身份";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *phoneNumberIMGV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mobile_select"]];
    phoneNumberIMGV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:phoneNumberIMGV];
    UIImageView *verifyIMGV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"verifyCode_select"]];
    verifyIMGV.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:verifyIMGV];
    self.phoneNumber = [[UITextField alloc] init];
    self.phoneNumber.placeholder = @"请输入手机号码";
    [self.view addSubview:self.phoneNumber];
    self.verify = [[UITextField alloc] init];
     self.verify.placeholder = @"请输入短信验证码";
    [self.view addSubview:self.verify];
    UIView *lineView_1 = [[UIView alloc] init];
    lineView_1.backgroundColor = INSETCOLOR;
    [self.view addSubview:lineView_1];
    UIView *lineView_2 = [[UIView alloc] init];
    lineView_2.backgroundColor =INSETCOLOR;
    [self.view addSubview:lineView_2];
    self.verifyButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:3 fontSize:14 title:@"获取验证码"];
    [self.view addSubview:self.verifyButton];
    
    UIButton *confirmButton = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor] backGroudColor:STYLECOLOR cornerRadius:4 fontSize:16 title:@"验证"];
    [self.view addSubview:confirmButton];
    [phoneNumberIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(15);
        make.leading.mas_equalTo(self.view).offset(CUSTOM_WIDTH(14));
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(16);
    }];
    
    [self.phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(phoneNumberIMGV);
        make.leading.mas_equalTo(phoneNumberIMGV.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(self.view).offset(-CUSTOM_WIDTH(14));
    }];
    
    [lineView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(phoneNumberIMGV.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
        make.trailing.mas_equalTo(self.view);
    }];
    
    [verifyIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lineView_1.mas_bottom).offset(15);
        make.leading.mas_equalTo(self.view).offset(CUSTOM_WIDTH(14));
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(16);
    }];
    
    [lineView_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(CUSTOM_WIDTH(14));
        make.top.mas_equalTo(verifyIMGV.mas_bottom).offset(15);
        make.height.mas_equalTo(1);
        make.trailing.mas_equalTo(self.view);
    }];
    
    [self.verifyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(verifyIMGV);
        make.trailing.mas_equalTo(self.view).offset(-CUSTOM_WIDTH(14));
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    [self.verifyButton addTarget:self action:@selector(getVerifyButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.verify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(verifyIMGV);
        make.leading.mas_equalTo(verifyIMGV.mas_trailing).offset(CUSTOM_WIDTH(14));
        make.trailing.mas_equalTo(self.verifyButton.mas_leading).offset(-CUSTOM_WIDTH(14));
    }];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.view).offset(CUSTOM_WIDTH(14));
        make.centerX.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(lineView_2.mas_bottom).offset(20);
    }];
     [confirmButton addTarget:self action:@selector(confirm:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)getVerifyButton:(UIButton *)sender{
    NSDictionary *param = @{@"mobileNo":self.phoneNumber.text};
    [MZAFNetwork POST:HOME_URL(@"/userInfo/sendLoginSms") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
        self.sec = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)timeAction{
    self.sec ++;
    self.verifyButton.userInteractionEnabled = NO;
    [self.verifyButton setBackgroundColor:COLOR_RGB16(0xd8d8d8)];
    [self.verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.verifyButton setTitle:[NSString stringWithFormat:@"%ld秒",60 -self.sec] forState:UIControlStateNormal];
    if (self.sec == 60 - 1) {
        self.verifyButton.userInteractionEnabled = YES;
        self.verifyButton.backgroundColor = STYLECOLOR;
        [self.verifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
    }
    
}
- (void)confirm:(UIButton *)sender{
    [self.view endEditing:YES];
    [MZAFNetwork POST:HOME_URL(@"/userInfo/verifySms") params:@{@"mobileNo":self.phoneNumber.text,@"smsCode":self.verify.text} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
            SetPayPasswordViewController *vc = [[SetPayPasswordViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
