
//
//  UserLoginViewController.m
//  JingXuan
//
//  Created by sfs on 2017/12/21.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "UserLoginViewController.h"
#import "UserLoginView.h"
#import "BaseNavigationController.h"
#import "WXLoginViewController.h"
#import "UserRegisterViewController.h"
#import "LoginForgetPasswordViewController.h"
@interface UserLoginViewController ()

@end

@implementation UserLoginViewController
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    UIButton *moveToRegister = [UIButton initCustomTypeButtonWithTextColor:TEXTCOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:16 title:@"注册"];
//    [moveToRegister addTarget:self action:@selector(moveToRegisterPage) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moveToRegister];
    self.title = @"窝窝遇上馍";
}
- (void)moveToRegisterPage{
    UserRegisterViewController *vc  = [[UserRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (instancetype)init{
    self = [super init];
    if (self) {
       UserLoginView *view = [[UserLoginView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXLogin:) name:@"WXLogin" object:nil];
}

- (void)WXLogin:(NSNotification *)sender{
    [MZAFNetwork POST:HOME_URL(@"/userInfo/wechatLogin") params:@{@"wxUnionId":[sender.userInfo objectForKey:@"unionid"]} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0002"]) {
            WXLoginViewController *vc = [[WXLoginViewController alloc] initWithAccess_token:[sender.userInfo objectForKey:@"access_token"] openid:[sender.userInfo objectForKey:@"openid"] unionId:[sender.userInfo objectForKey:@"unionid"]];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            UserConfig *userConfig = [UserConfig shareInstance];
            userConfig = [UserConfig yy_modelWithDictionary:[responseObject objectForKey:@"userInfoForm"]];
                        userConfig.isPayPassword = [responseObject valueForKey:@"isPayPassword"];
            [[NSUserDefaults standardUserDefaults] setObject: [NSKeyedArchiver archivedDataWithRootObject:userConfig] forKey:@"userConfig"];
            [(BaseNavigationController *)self.navigationController  loginSuccessPopViewControllerAnimated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loginAction:(UIButton *)button{
    if (((UserLoginView *)self.view).phoneNumTextField.text == 0 || ((UserLoginView *)self.view).passwordTextField.text == 0) {
        [Tool showMessage:@"账号或密码不能为空" duration:3];
        return;
    }
    if (((UserLoginView *)self.view).selectIndex == 0) {
        NSDictionary *param = @{@"mobileNo":((UserLoginView *)self.view).phoneNumTextField.text,
                                @"password":((UserLoginView *)self.view).passwordTextField.text};
        [MZAFNetwork POST:HOME_URL(@"/userInfo/login") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
                UserConfig *userConfig = [UserConfig shareInstance];
                userConfig = [UserConfig yy_modelWithDictionary:[responseObject objectForKey:@"userInfoForm"]];
                 userConfig.isPayPassword = [responseObject valueForKey:@"isPayPassword"];
                [[NSUserDefaults standardUserDefaults] setObject: [NSKeyedArchiver archivedDataWithRootObject:userConfig] forKey:@"userConfig"];
                [(BaseNavigationController *)self.navigationController  loginSuccessPopViewControllerAnimated:YES];
            }else{
                [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            ;
        }];
    }else{
    NSDictionary *param = @{@"mobileNo":((UserLoginView *)self.view).phoneNumTextField.text,
                            @"smsCode":((UserLoginView *)self.view).passwordTextField.text};
    [MZAFNetwork POST:HOME_URL(@"/userInfo/smsLogin") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            UserConfig *userConfig = [UserConfig shareInstance];
            userConfig = [UserConfig yy_modelWithDictionary:[responseObject objectForKey:@"userInfoForm"]];
            userConfig.isPayPassword = [responseObject valueForKey:@"isPayPassword"];
            [[NSUserDefaults standardUserDefaults] setObject: [NSKeyedArchiver archivedDataWithRootObject:userConfig] forKey:@"userConfig"];
            [(BaseNavigationController *)self.navigationController  loginSuccessPopViewControllerAnimated:YES];
        }else{
            [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
    }
}

- (void)getVerifyCodeMoveToPage:(BOOL)move{
    NSDictionary *param = @{@"mobileNo":((UserLoginView *)self.view).phoneNumTextField.text};
    [MZAFNetwork POST:HOME_URL(@"/userInfo/sendLoginSms") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
        if (move) {
            LoginForgetPasswordViewController *vc = [[LoginForgetPasswordViewController alloc] initWithMobileNo:((UserLoginView *)self.view).phoneNumTextField.text];
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
