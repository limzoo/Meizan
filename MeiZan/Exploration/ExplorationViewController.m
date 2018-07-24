
//
//  ExplorationViewController.m
//  JingXuan
//
//  Created by sfs on 2017/12/19.
//  Copyright © 2017年 rhjt. All rights reserved.
//
//没错!他就是消息!

#import "ExplorationViewController.h"
#import "ExplorationView.h"
#import "UserMessageModel.h"
@interface ExplorationViewController ()
@property (nonatomic, strong) NSMutableArray *modelArray;
@end

@implementation ExplorationViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      [self preLoginAction];
    ExplorationView *view = [[ExplorationView alloc] initWithFrame:self.view.frame];
    self.view = view;
    self.title = @"消息";
    UIButton *readAll = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:16 title:@"全部已读"];
    readAll.frame = CGRectMake(0, 0, 80, 44);
    readAll.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [readAll addTarget:self action:@selector(readAllAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:readAll];
}

- (void)readAllAction{
    [MZAFNetwork POST:HOME_URL(@"/messageInfo/updateMessageIsRead") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self loadPageDataWithType:((ExplorationView *)self.view).currentIndex + 1 withPage:1];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)preLoginAction{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url =  HOME_URL(@"/userInfo/isLogin");
    NSData *userConfigData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"];
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:userConfigData];
    if (config.userInfo.userId != 0) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?appId=%@&userId=%ld",[UIDevice currentDevice].identifierForVendor.UUIDString, config.userInfo.userId]];
    }else{
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?appId=%@",[UIDevice currentDevice].identifierForVendor.UUIDString]];
    }
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self loadPageDataWithType:((ExplorationView *)self.view).currentIndex + 1 withPage:1];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self loadPageDataWithType:((ExplorationView *)self.view).currentIndex + 1 withPage:1];
    }];
}

- (void)loadPageDataWithType:(NSInteger)type withPage:(NSInteger)page{
    NSDictionary *param = @{@"page":[NSNumber numberWithInteger:page],
                            @"limit":@"20",
                            @"sendWay":[NSNumber numberWithInteger:type],
                            };
    [MZAFNetwork POST:HOME_URL(@"/messageInfo/queryMessageInfoPage") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        [((ExplorationView *)self.view).mainTableView.mj_header endRefreshing];
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
            if (page == 1) {
                [self.modelArray removeAllObjects];
            }
            if ([[responseObject objectForKey:@"messageInfoList"] isKindOfClass:[NSArray class]]) {
                if (((NSArray *)[responseObject objectForKey:@"messageInfoList"]).count != 0) {
                    for (NSDictionary *dic in [responseObject objectForKey:@"messageInfoList"]) {
                        UserMessageModel *model = [UserMessageModel yy_modelWithDictionary:dic];
                        [self.modelArray addObject:model];
                    }
                    [((ExplorationView *)self.view).mainTableView.mj_footer endRefreshing];
                }else{
                    [((ExplorationView *)self.view).mainTableView.mj_footer endRefreshingWithNoMoreData];
                }
                ((ExplorationView *)self.view).modelArray = self.modelArray;
            }
        }else{
            ((ExplorationView *)self.view).modelArray = @[];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        _modelArray = [NSMutableArray array];
    }
    return _modelArray;
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
