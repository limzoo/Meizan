//
//  ShareViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/30.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareView.h"
@interface ShareViewController ()

@end

@implementation ShareViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        ShareView *view = [[ShareView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"我要推荐";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
