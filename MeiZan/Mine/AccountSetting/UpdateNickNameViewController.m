//
//  UpdateNickNameViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UpdateNickNameViewController.h"
#import "UpdateNickNameView.h"
@interface UpdateNickNameViewController ()

@end

@implementation UpdateNickNameViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        UpdateNickNameView *view = [[UpdateNickNameView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"修改昵称";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveNickname:(NSString *)nickName{
    [MZAFNetwork POST:HOME_URL(@"/userInfo/updateNickName") params:@{@"nickName":nickName} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
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
