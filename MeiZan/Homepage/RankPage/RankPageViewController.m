//
//  RankPageViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/15.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "RankPageViewController.h"
#import "UserMessageModel.h"
#import "RankPageView.h"
@interface RankPageViewController ()
@property (nonatomic, strong) NSMutableArray *titlesArray;
@end

@implementation RankPageViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        RankPageView *view = [[RankPageView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"排行榜";
    [self loadPageData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPageData{
    NSDictionary *param = @{@"page":@"1",
                            @"limit":@"9999",
                            @"sendWay":@"3",
                            };
    [MZAFNetwork POST:HOME_URL(@"/messageInfo/queryMessageInfoPage") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
            [self.titlesArray removeAllObjects];
            if ([[responseObject objectForKey:@"messageInfoList"] isKindOfClass:[NSString class]]) {
                return ;
            }
            for (NSDictionary *dic in [responseObject objectForKey:@"messageInfoList"]) {
                UserMessageModel *model = [UserMessageModel yy_modelWithDictionary:dic];
                [self.titlesArray addObject:model];
            }
            ((RankPageView *)self.view).titlesArray = self.titlesArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (NSMutableArray *)titlesArray{
    if (!_titlesArray) {
        _titlesArray = [NSMutableArray array];
    }
    return _titlesArray;
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
