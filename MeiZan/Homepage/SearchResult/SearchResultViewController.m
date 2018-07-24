//
//  SearchResultViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/21.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResult.h"
#import "MerchandiseModel.h"
#import "BaseSearchBar.h"
#import "MerchandiseCollectionViewCell.h"
#import "SearchResultViewController.h"
@interface SearchResultViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSString *style;
@property (nonatomic, strong) NSMutableArray *merchandiseArray;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSString *currentKeyWords;
@end

@implementation SearchResultViewController
- (instancetype)initWithDataArray:(NSArray *)dataArray type:(NSString *)style categoryName:(NSString *)categoryName keyWords:(NSString *)keyWords{
    self  = [super init];
    if (self) {
        self.categoryName = categoryName;
        self.currentKeyWords = keyWords;
        self.style = style;
        SearchResult *view = [[SearchResult alloc] initWithFrame:self.view.frame];
        self.merchandiseArray = [NSMutableArray arrayWithArray:dataArray];
        view.mainCollectionView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
            self.currentPage ++;
            [self getPageDataWithKeywords:self.currentKeyWords withPage:self.currentPage];
            [view.mainCollectionView.mj_footer endRefreshing];
        }];
        view.dataArray = dataArray;
        if (dataArray.count < 10) {
            view.mainCollectionView.mj_footer.hidden = YES;
        }
        self.view = view;
        self.currentPage = 1;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
- (void)getPageDataWithKeywords:(NSString *)keywords withPage:(NSInteger)page{
    self.currentKeyWords = keywords;
    self.currentPage = page;
    NSDictionary *paramDic = @{@"goodsName":[NSNull null],
                               @"categoryName":self.categoryName,
                               @"minimumPrice":@0,
                               @"maximumPrice":@9999,
                               @"style":self.style,
                               @"orderBy":[NSNull null],
                               @"keywords":keywords,
                               @"page":[NSNumber numberWithInteger:page]};
    [MZAFNetwork POST:HOME_URL(@"/shopGoodsInfo/queryList") params:paramDic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            if (self.currentPage == 1) {
                [self.merchandiseArray removeAllObjects];
            }
            if (((NSArray *)[responseObject objectForKey:@"shopGoodsInfoList"]).count == 0) {
                 ((SearchResult *)self.view).dataArray  = self.merchandiseArray;
                [((SearchResult *)self.view).mainCollectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                for (NSDictionary *modelDic in [responseObject objectForKey:@"shopGoodsInfoList"]) {
                    MerchandiseModel *model = [MerchandiseModel yy_modelWithDictionary:modelDic];
                    [self.merchandiseArray addObject:model];
                }
                ((SearchResult *)self.view).dataArray  = self.merchandiseArray;
            }
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
