//
//  CommissionWithdrawViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "CommissionWithdrawViewController.h"
#import "CommissionWithdraw.h"
@interface CommissionWithdrawViewController ()

@end

@implementation CommissionWithdrawViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        CommissionWithdraw *view = [[CommissionWithdraw alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    self.title = @"佣金转出";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)transferBrokerage:(CGFloat)brokerage{
    [MZAFNetwork POST:HOME_URL(@"/acAccount/transferBrokerage") params:@{@"amount":[NSNumber numberWithFloat:brokerage]} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [Tool showMessage:@"转出成功" duration:3];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
             [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3 atCenter:YES];
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
