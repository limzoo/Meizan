//
//  UserFeedbViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/24.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UserFeedbViewController.h"
#import "UserFeedbackView.h"
@interface UserFeedbViewController ()

@end

@implementation UserFeedbViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        UserFeedbackView *view = [[UserFeedbackView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"客户信息反馈";
}

- (void)userFeedbackWithString:(NSString *)str{
    [MZAFNetwork POST:HOME_URL(@"/userFeedbackInfo/insertUserFeedback") params:@{@"content":str} success:^(NSURLSessionDataTask *task, id responseObject) {
        [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
