//
//  RankDetailViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/15.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "RankDetailViewController.h"
#import "RankDetailView.h"
#import "RankDetailModel.h"
@interface RankDetailViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSString *newsTitle;
@property (nonatomic, strong) NSMutableArray *rankArray;
@end

@implementation RankDetailViewController
- (instancetype)initWithNewsTitles:(NSString *)title{
    self = [super init];
    if (self) {
        RankDetailView *view = [[RankDetailView alloc] initWithFrame:self.view.frame];
        self.view = view;
        self.newsTitle = title;
        view.titleLabel.text = title;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self loadPageData];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)loadPageData{
    NSDictionary *paramDic = @{@"ranksInfo.rankName":self.newsTitle};
    [MZAFNetwork POST:HOME_URL(@"/ranksInfo/query") params:paramDic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.rankArray removeAllObjects];
            for (NSDictionary *dic in [responseObject objectForKey:@"ranksInfoList"]) {
                RankDetailModel *model = [RankDetailModel yy_modelWithDictionary:dic];
                UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
                if (model.USER_ID == config.userInfo.userId) {
                    ((RankDetailView *)self.view).userRank = model.RANK;
                }
                [self.rankArray addObject:model];
            }
            ((RankDetailView *)self.view).rankArray = self.rankArray;
            ((RankDetailView *)self.view).userAmount = ((NSNumber *)[responseObject objectForKey:@"transAmount"]).longValue;
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

- (NSMutableArray *)rankArray{
    if (!_rankArray) {
        _rankArray = [NSMutableArray array];
    }
    return _rankArray;
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
