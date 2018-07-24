//
//  LoginForgetPasswordViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/3/7.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "LoginForgetPasswordViewController.h"
#import "LoginForgetPasswordView.h"
#import "LoginResetPasswordViewController.h"
@interface LoginForgetPasswordViewController ()
@property (nonatomic, strong) NSString *mobileNo;
@end

@implementation LoginForgetPasswordViewController
- (instancetype)initWithMobileNo:(NSString *)mobileNO{
    self = [super init];
    if (self) {
        LoginForgetPasswordView *view = [[LoginForgetPasswordView alloc] initWithFrame:self.view.frame];
        self.mobileNo = mobileNO;
        view.annouceLabel.text = [view.annouceLabel.text stringByAppendingString:mobileNO];
        self.view = view;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)verifyUserCode:(NSString *)code{
    [MZAFNetwork POST:HOME_URL(@"/userInfo/verifySms") params:@{@"mobileNo":self.mobileNo,@"smsCode":code} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"]  isEqualToString:@"0000"]) {
            LoginResetPasswordViewController *vc = [[LoginResetPasswordViewController alloc] initWithPhoneNumber:self.mobileNo];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;   
    }];
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
