//
//  MyAgentViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyAgentViewController.h"
#import "MyAgentModel.h"
#import "MyAgentView.h"
@interface MyAgentViewController ()
@property (nonatomic, strong) MyAgentModel *parentInfo;
@property (nonatomic, strong) NSMutableArray *childInfoArray;
@property (nonatomic, strong) MyAgentModel *userInfo;
@end

@implementation MyAgentViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        MyAgentView *view = [[MyAgentView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"代理商";
    [self loadMyAgent];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadMyAgent{
    [MZAFNetwork POST:HOME_URL(@"/userInfo/levelQuery") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.childInfoArray removeAllObjects];
            self.parentInfo = [MyAgentModel yy_modelWithJSON:[responseObject objectForKey:@"parentInfo"]];
            self.userInfo = [MyAgentModel yy_modelWithJSON:[responseObject objectForKey:@"userInfo"]];
            for (NSDictionary *dic in [responseObject objectForKey:@"childInfoList"]) {
                MyAgentModel *model = [MyAgentModel yy_modelWithDictionary:dic];
                [self.childInfoArray addObject:model];
            }
            ((MyAgentView *)self.view).childInfoArray = self.childInfoArray;
            ((MyAgentView *)self.view).parentInfo = self.parentInfo;
            ((MyAgentView *)self.view).userInfo = self.userInfo;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (MyAgentModel *)parentInfo{
    if (!_parentInfo) {
        _parentInfo = [[MyAgentModel alloc] init];
    }
    return _parentInfo;
}
- (NSMutableArray *)childInfoArray{
    if (!_childInfoArray) {
        _childInfoArray = [NSMutableArray array];
    }
    return _childInfoArray;
}

- (MyAgentModel *)userInfo{
    if (!_userInfo) {
        _userInfo = [[MyAgentModel alloc] init];
    }
    return _userInfo;
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
