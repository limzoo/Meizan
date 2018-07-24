//
//  TypePageViewController.m
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "TypePageViewController.h"
#import "TypePageView.h"
#import "TypeModel.h"
#import "MerchandiseModel.h"
#import "SearchResultViewController.h"
@interface TypePageViewController ()
@property (nonatomic, strong) NSMutableArray<TypeModel *> *typeArray;
@property (nonatomic, strong) NSMutableArray<MerchandiseModel *> *merchandiseArray;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger typeIndex;


@property (nonatomic, assign) BOOL isFirstTime;
@end

@implementation TypePageViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        self.currentPage = 1;
        self.isFirstTime = YES;
        TypePageView *view = [[TypePageView alloc] initWithFrame:self.view.frame];
        __weak typeof(self) weakSelf = self;
        MJRefreshAutoNormalFooter *footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadTypeMerchandiseWithTypeIndex:self.typeIndex withPage:++weakSelf.currentPage];
        }];
        view.merchandiseCollectonView.mj_footer = footer;
        view.merchandiseCollectonView.mj_header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            weakSelf.currentPage = 1;
            [weakSelf loadTypeMerchandiseWithTypeIndex:self.typeIndex withPage:weakSelf.currentPage];
        }];
        self.view = view;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    if (self.isFirstTime) {
        [self loadPageDataWithParentId:0 page:1 limit:999];
        self.isFirstTime = NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getPageDataMoveToPageWithgoodsName:(NSString *)goodsName categoryName:(NSString *)categoryName minimumPrice:(NSInteger)minimumPrice maximumPrice:(NSInteger)maximumPrice style:(NSString *)style orderBy:(NSString *)orderBy keywords:(NSString *)keywords page:(NSNumber *)page{
    NSDictionary *paramDic = @{@"goodsName":goodsName,
                               @"categoryName":categoryName,
                               @"minimumPrice":[NSNumber numberWithInteger:minimumPrice],
                               @"maximumPrice":[NSNumber numberWithInteger:maximumPrice],
                               @"style":style,
                               @"orderBy":orderBy,
                               @"keywords":keywords,
                               @"page":page};
    [MZAFNetwork POST:HOME_URL(@"/shopGoodsInfo/queryList") params:paramDic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            NSMutableArray *array = [NSMutableArray array];
            if (((NSArray *)[responseObject objectForKey:@"shopGoodsInfoList"]).count < 5 && page.intValue == 1) {
                [((TypePageView *)self.view).merchandiseCollectonView.mj_footer endRefreshingWithNoMoreData];
            }else if (((NSArray *)[responseObject objectForKey:@"shopGoodsInfoList"]).count < 10 && page.intValue > 1) {
                [((TypePageView *)self.view).merchandiseCollectonView.mj_footer endRefreshingWithNoMoreData];
            }else{
                 [((TypePageView *)self.view).merchandiseCollectonView.mj_footer endRefreshing];
            }
            for (NSDictionary *modelDic in [responseObject objectForKey:@"shopGoodsInfoList"]) {
                MerchandiseModel *model = [MerchandiseModel yy_modelWithDictionary:modelDic];
                [array addObject:model];
            }
            SearchResultViewController *vc = [[SearchResultViewController alloc] initWithDataArray:array type:style categoryName:categoryName keyWords:keywords];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)loadPageDataWithParentId:(NSInteger)parentId page:(NSInteger)page limit:(NSInteger)limit{
    NSDictionary *param = @{@"parentId":[NSNumber numberWithInteger: parentId],
                                @"limit":[NSNumber numberWithInteger: limit],
                                @"page":[NSNumber numberWithInteger: page],
                            };
    [MZAFNetwork POST:HOME_URL(@"/shopCategoryInfo/queryShopCategoryInfoList") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.typeArray removeAllObjects];
            for (NSDictionary *dic in [responseObject objectForKey:@"shopCategoryInfoList"]) {
                TypeModel *model = [[TypeModel alloc] init];
                model = [TypeModel yy_modelWithDictionary:dic];
                [self.typeArray addObject:model];
            }
            [self loadTypeMerchandiseWithTypeIndex:0 withPage:1];
            ((TypePageView *)self.view).typeTitleArray = self.typeArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)loadTypeMerchandiseWithTypeIndex:(NSInteger)index withPage:(NSInteger)page{
    self.typeIndex = index;
    self.currentPage = page;
    TypeModel *model = self.typeArray[index];
    NSDictionary *param = @{@"categoryName":model.categoryName,
                            @"page":[NSNumber numberWithInteger:page],
                            };
    [MZAFNetwork POST:HOME_URL(@"/shopGoodsInfo/queryList") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        [((TypePageView *)self.view).merchandiseCollectonView.mj_header endRefreshing];
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
            if (page == 1) {
                [self.merchandiseArray removeAllObjects];
            }
            if (((NSArray *)[responseObject objectForKey:@"shopGoodsInfoList"]).count < 5 && page == 1) {
                ((TypePageView *)self.view).merchandiseCollectonView.mj_footer.hidden = YES;
            }else if (((NSArray *)[responseObject objectForKey:@"shopGoodsInfoList"]).count < 10 && page > 1) {
                [((TypePageView *)self.view).merchandiseCollectonView.mj_footer endRefreshingWithNoMoreData];
            }
            for (NSDictionary *dic in [responseObject objectForKey:@"shopGoodsInfoList"]) {
               MerchandiseModel *model = [MerchandiseModel yy_modelWithDictionary:dic];
                [self.merchandiseArray addObject:model];
            }
            ((TypePageView *)self.view).merchandiseArray = self.merchandiseArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (NSMutableArray<TypeModel *> *)typeArray{
    if (!_typeArray) {
        _typeArray = [NSMutableArray array];
    }
    return _typeArray;
}

- (NSMutableArray<MerchandiseModel *> *)merchandiseArray{
    if (!_merchandiseArray) {
        _merchandiseArray = [NSMutableArray array];
    }
    return _merchandiseArray;
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
