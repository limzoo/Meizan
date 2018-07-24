//
//  UserRegisterViewController.m
//  JingXuan
//
//  Created by sfs on 2017/12/22.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "UserRegisterViewController.h"
#import "UserRegisterView.h"
@interface UserRegisterViewController ()

@end

@implementation UserRegisterViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        UserRegisterView *view = [[UserRegisterView alloc] initWithFrame:self.view.frame];
        self.view = view;
        self.title = @"手机快速注册";
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

- (void)getVerifyCodeWithPhoneNum:(NSString *)phoneNo{
    NSDictionary *param = @{@"mobileNo":phoneNo,
                            @"sendType":@"regSend"};
    [MZAFNetwork POST:HOME_URL(@"/userInfo/sendRegisterSms") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)registerActionWithMobileNo:(NSString *)mobileNo smsCode:(NSString *)smsCode inviteCode:(NSString *)inviteCode password:(NSString *)password nickName:(NSString *)nickName{
    NSDictionary *param = @{@"mobileNo":mobileNo,
                            @"smsCode":smsCode,
                            @"password":password,
                            @"nickName":nickName,
                            @"invitationId":inviteCode,
                            @"device_type":@"ios"
                            };
    [MZAFNetwork POST:HOME_URL(@"/userInfo/userRegister") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.navigationController popViewControllerAnimated:YES];
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
