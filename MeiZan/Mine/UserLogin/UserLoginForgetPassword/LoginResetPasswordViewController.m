//
//  LoginResetPasswordViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/3/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "LoginResetPasswordViewController.h"
#import "LoginResetPasswordView.h"
#import "UserLoginViewController.h"
@interface LoginResetPasswordViewController ()
@property (nonatomic, strong) NSString *userPhonnNumber;
@end

@implementation LoginResetPasswordViewController
- (instancetype)initWithPhoneNumber:(NSString *)phoneNumber{
    self = [super init];
    if (self) {
        self.userPhonnNumber = phoneNumber;
        LoginResetPasswordView *view = [[LoginResetPasswordView alloc] initWithFrame:self.view.frame];
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

- (void)resetPasswordNewPassword:(NSString *)newPassword{
    [MZAFNetwork POST:HOME_URL(@"/userInfo/resetPassword") params:@{@"mobileNo":self.userPhonnNumber,@"newPassword":newPassword} success:^(NSURLSessionDataTask *task, id responseObject) {
        [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[UserLoginViewController class]]) {
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
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
