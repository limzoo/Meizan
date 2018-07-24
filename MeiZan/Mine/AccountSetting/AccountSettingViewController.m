//
//  AccountSettingViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "AccountSettingViewController.h"
#import "AccountSettingView.h"
@interface AccountSettingViewController ()

@end

@implementation AccountSettingViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        AccountSettingView *view = [[AccountSettingView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    self.title = @"账户设置";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logOut{
    [MZAFNetwork POST:HOME_URL(@"/userInfo/outLogin") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userConfig"];
        [self.navigationController popViewControllerAnimated:YES];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
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
