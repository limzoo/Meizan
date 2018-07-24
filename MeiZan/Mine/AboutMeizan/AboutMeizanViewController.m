//
//  AboutMeizanViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "AboutMeizanViewController.h"
#import "AboutMeiZan.h"
@interface AboutMeizanViewController ()

@end

@implementation AboutMeizanViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        AboutMeiZan *view = [[AboutMeiZan alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"关于我们";
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
