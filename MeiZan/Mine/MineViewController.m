//
//  MineViewController.m
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MineViewController.h"
#import "MineView.h"
#import "UserLoginViewController.h"
@interface MineViewController ()

@end

@implementation MineViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        MineView *view = [[MineView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
     [((MineView *)self.view).mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadPageData];
}

- (void)loadPageData{
    [MZAFNetwork POST:HOME_URL(@"/userInfo/index") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
            /*    "brokerage": 0.00,
            "phnotoUrl": "",
            "balance": 0.00,
            "integral": 0.05,
            "nickName": "Linyu",
            "levelName": "普通会员",
            "return_msg": "查询成功",
            "mobileNo": "18825157133",
            "return_code": "0000"*/
            config.userInfo.balance = [responseObject objectForKey:@"balance"];
            config.userInfo.integral = [responseObject objectForKey:@"integral"];
            config.levelName = [responseObject objectForKey:@"levelName"];
            config.userInfo.mobileNo = [responseObject objectForKey:@"mobileNo"];
            config.merchantInfo.merchantName = [responseObject objectForKey:@"merchantName"];
            config.userInfo.brokerage = [responseObject objectForKey:@"brokerage"];
            config.userInfo.nickName = [responseObject objectForKey:@"nickName"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:config] forKey:@"userConfig"];
        }
        [((MineView *)self.view).mainTableView reloadData];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
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
