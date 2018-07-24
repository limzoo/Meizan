//
//  WXLoginBindViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "WXLoginBindViewController.h"
#import "WXLoginBindView.h"
@interface WXLoginBindViewController ()
@property (nonatomic, strong) NSString *wxUnionId;
@property (nonatomic, strong) NSString *wxOpenId;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *photoUrl;
@end

@implementation WXLoginBindViewController
- (instancetype)initWithWxUnionId:(NSString *)wxUnionId wxOpenId:(NSString *)wxOpenId nickName:(NSString *)nickName photoUrl:(NSString *)photoUrl{
    self = [super init];
    if (self) {
        self.wxOpenId = wxOpenId;
        self.wxUnionId = wxUnionId;
        self.nickName = nickName;
        self.photoUrl = photoUrl;
        WXLoginBindView *view = [[WXLoginBindView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"绑定账号";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getVerifyCode{
    if (((WXLoginBindView *)self.view).phoneNumTextField.text.length == 0) {
        [Tool showMessage:@"请输入手机号码" duration:3];
    }
    NSDictionary *param = @{@"mobileNo":((WXLoginBindView *)self.view).phoneNumTextField.text,
                            @"sendType":@"wxBindSend"};
    [MZAFNetwork POST:HOME_URL(@"/userInfo/sendRegisterSms") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)bindActionWithMobileNo:(NSString *)mobileNo smsCode:(NSString*)smsCode{
    NSDictionary *param = @{@"mobileNo":mobileNo,
                            @"smsCode":smsCode,
                            @"wxUnionId":self.wxUnionId,
                            @"wxOpenId":self.wxOpenId,
                            @"nickName":self.nickName,
                            @"photoUrl":self.photoUrl,
                            };
    [MZAFNetwork POST:HOME_URL(@"/userInfo/wxGzhconfirmSms") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self wxAutoLogin];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)wxAutoLogin{
    [MZAFNetwork POST:HOME_URL(@"/userInfo/wechatLogin") params:@{@"wxUnionId":self.wxUnionId} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            UserConfig *userConfig = [UserConfig shareInstance];
            userConfig = [UserConfig yy_modelWithDictionary:[responseObject objectForKey:@"userInfoForm"]];
             userConfig.isPayPassword = [responseObject valueForKey:@"isPayPassword"];
            [[NSUserDefaults standardUserDefaults] setObject: [NSKeyedArchiver archivedDataWithRootObject:userConfig] forKey:@"userConfig"];
            [(BaseNavigationController *)self.navigationController popToRootViewControllerAnimated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
