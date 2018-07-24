//
//  ResetPasswordViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "ResetPassword.h"
@interface ResetPasswordViewController ()

@end

@implementation ResetPasswordViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        ResetPassword *view = [[ResetPassword alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    self.title = @"修改登录密码";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetPasswordWithOldPassword:(NSString *)old newPassword:(NSString *)newP{
    [self.view endEditing:YES];
    if (old.length == 0) {
        [Tool showMessage:@"请输入原始密码" duration:3];
        return;
    }
    if (newP.length == 0) {
        [Tool showMessage:@"请输入新的密码" duration:3];
        return;
    }
    [MZAFNetwork POST:HOME_URL(@"/userInfo/updatePasswordByOld") params:@{@"oldPassword":old,@"password":newP} success:^(NSURLSessionDataTask *task, id responseObject) {
        [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
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
