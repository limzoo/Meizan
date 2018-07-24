//
//  PopularizeViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/3/15.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "PopularizeViewController.h"
#import "PopularizeView.h"
@interface PopularizeViewController ()

@end

@implementation PopularizeViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        PopularizeView *view = [[PopularizeView alloc] initWithFrame:self.view.frame];
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
- (void)uploadPopularizationMsg:(NSString *)name mobileNo:(NSString *)mobileNo area:(NSString *)area{
    [MZAFNetwork POST:HOME_URL(@"/recommendInfo/recommend") params:@{@"customerName":name,@"customerMobileNo":mobileNo,@"plannedArea":area} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
            [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
              [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
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
