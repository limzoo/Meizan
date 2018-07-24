//
//  HomepageViewController.m
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "HomepageViewController.h"
#import "HompageView.h"
#import "MerchandiseModel.h"
#import "UserMessageModel.h"
#import "SearchResultViewController.h"
#import "ADModel.h"
#import "AppDelegate.h"
#import "RankDetailModel.h"
#import "BlockDetailViewController.h"
@interface HomepageViewController ()
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray<MerchandiseModel *> *merchandiseArray;
@property (nonatomic, assign) NSUInteger currentPage;
@property (nonatomic, strong) NSMutableArray *titlesArray;
@property (nonatomic, strong) NSMutableArray *ADArray;
@property (nonatomic, strong) NSMutableArray *rankArray;
@end

@implementation HomepageViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        HompageView *view = [[HompageView alloc] initWithFrame:self.view.frame];
        view.mainCollectionView.mj_footer = [MJRefreshAutoStateFooter footerWithRefreshingBlock:^{
            self.currentPage ++;
            [self getPageDataWithgoodsName:[NSNull null] categoryName:[NSNull null] minimumPrice:0 maximumPrice:99999 style:[NSNull null] orderBy:[NSNull null] keywords:[NSNull null] page:[NSNumber numberWithInteger:self.currentPage]];
        }];
        self.view = view;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.currentPage = 1;
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self preLoginAction];
    [self loadScrollingAd];
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [((HompageView *)self.view).mainCollectionView reloadData];
   });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPageList];
    [self getPageDataWithgoodsName:[NSNull null] categoryName:[NSNull null] minimumPrice:0 maximumPrice:99999 style:[NSNull null] orderBy:[NSNull null] keywords:[NSNull null] page:[NSNumber numberWithInteger:1]];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];

}
- (void)preLoginAction{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSString *url =  HOME_URL(@"/userInfo/isLogin");
    NSData *userConfigData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:userConfigData];
    if (config.userInfo.userId != 0) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?appId=%@&userId=%ld",[UIDevice currentDevice].identifierForVendor.UUIDString, config.userInfo.userId]];
    }else{
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?appId=%@",[UIDevice currentDevice].identifierForVendor.UUIDString]];
    }
    [manager POST:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self loadScrollingNews];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self loadScrollingNews];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadRankDetailWithTitle:(NSString *)newsTitle{
    NSDictionary *paramDic = @{@"ranksInfo.rankName":newsTitle};
    [MZAFNetwork POST:HOME_URL(@"/ranksInfo/query") params:paramDic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.rankArray removeAllObjects];
            for (NSDictionary *dic in [responseObject objectForKey:@"ranksInfoList"]) {
                RankDetailModel *model = [RankDetailModel yy_modelWithDictionary:dic];
                [self.rankArray addObject:model];
            }
            ((HompageView *)self.view).rankArray = self.rankArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)getPageList{
    [MZAFNetwork POST:HOME_URL(@"/shopGoodsInfo/queryGoodsInfoList") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            ((HompageView *)self.view).listMerchandiseDict = responseObject;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)getPageDataWithgoodsName:(NSString *)goodsName categoryName:(NSString *)categoryName minimumPrice:(NSInteger)minimumPrice maximumPrice:(NSInteger)maximumPrice style:(NSString *)style orderBy:(NSString *)orderBy keywords:(NSString *)keywords page:(NSNumber *)page{
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
            if (self.currentPage == 1) {
                [self.merchandiseArray removeAllObjects];
            }
            if (((NSArray *)[responseObject objectForKey:@"shopGoodsInfoList"]).count == 0) {
                [((HompageView *)self.view).mainCollectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                for (NSDictionary *modelDic in [responseObject objectForKey:@"shopGoodsInfoList"]) {
                    MerchandiseModel *model = [MerchandiseModel yy_modelWithDictionary:modelDic];
                    [self.merchandiseArray addObject:model];
                }
                ((HompageView *)self.view).merchandiseArray  = self.merchandiseArray;
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [((HompageView *)self.view).mainCollectionView reloadSections:[NSIndexSet indexSetWithIndex:7]];
                });
                [((HompageView *)self.view).mainCollectionView.mj_footer endRefreshing];
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)getPageDataMoveToPageWithgoodsName:(NSString *)goodsName categoryName:(NSString *)categoryName minimumPrice:(NSInteger)minimumPrice maximumPrice:(NSInteger)maximumPrice style:(NSString *)style orderBy:(NSString *)orderBy keywords:(NSString *)keywords page:(NSNumber *)page{
    if (![style isKindOfClass:[NSNull class]] && [style isEqualToString:@"jifen"]) {
        NSDictionary *paramDic = @{
                                   @"categoryName":@"积分兑换区",
                                   @"page":page};
        [MZAFNetwork POST:HOME_URL(@"/shopGoodsInfo/queryList") params:paramDic success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *modelDic in [responseObject objectForKey:@"shopGoodsInfoList"]) {
                    MerchandiseModel *model = [MerchandiseModel yy_modelWithDictionary:modelDic];
                    [array addObject:model];
                }
                BlockDetailViewController *vc = [[BlockDetailViewController alloc] initWithDataArray:array type:style categoryName:categoryName keyWords:keywords];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            ;
        }];
    }else{
        NSDictionary *paramDic = @{@"goodsName":goodsName,
                                   @"categoryName":categoryName,
                                   @"minimumPrice":[NSNumber numberWithInteger:minimumPrice],
                                   @"maximumPrice":[NSNumber numberWithInteger:maximumPrice],
                                   @"style":style,
                                   @"orderBy":orderBy,
                                   @"keywords":keywords,
                                   @"page":page};
        
        if ([style isEqualToString:@"goods_yh"]) {
            paramDic = @{@"goodsName":goodsName,
                         @"categoryName":@"促销商品",
                         @"minimumPrice":[NSNumber numberWithInteger:minimumPrice],
                         @"maximumPrice":[NSNumber numberWithInteger:maximumPrice],
                         @"style":[NSNull null],
                         @"orderBy":orderBy,
                         @"keywords":keywords,
                         @"page":page};
        }else{
            
        }
    [MZAFNetwork POST:HOME_URL(@"/shopGoodsInfo/queryList") params:paramDic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *modelDic in [responseObject objectForKey:@"shopGoodsInfoList"]) {
                MerchandiseModel *model = [MerchandiseModel yy_modelWithDictionary:modelDic];
                [array addObject:model];
            }
             BlockDetailViewController *vc = [[ BlockDetailViewController alloc] initWithDataArray:array type:style categoryName:categoryName keyWords:keywords];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
    }
}
- (NSMutableArray<MerchandiseModel *> *)merchandiseArray{
    if (!_merchandiseArray) {
        _merchandiseArray = [NSMutableArray array];
    }
    return _merchandiseArray;
}

- (void)loadScrollingNews{
    NSDictionary *param = @{@"page":@"1",
                            @"limit":@"999",
                            @"sendWay":@"3",
                            };
    [MZAFNetwork POST:HOME_URL(@"/messageInfo/queryMessageInfoPage") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
            [self.titlesArray removeAllObjects];
            if ([[responseObject objectForKey:@"messageInfoList"] isKindOfClass:[NSString class]]) {
                NSString *str = [responseObject objectForKey:@"messageInfoList"];
                if(str.length == 0){
                    return ;
                }
            }
            for (NSDictionary *dic in [responseObject objectForKey:@"messageInfoList"]) {
                UserMessageModel *model = [UserMessageModel yy_modelWithDictionary:dic];
                [self.titlesArray addObject:model];
            }
            ((HompageView *)self.view).scrollingTitlesArray = self.titlesArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)loadScrollingAd{
    [MZAFNetwork POST:HOME_URL(@"/bsAd/queryAdList") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
            [self.ADArray removeAllObjects];
            for (NSDictionary *dic in [responseObject objectForKey:@"adList"]) {
                ADModel *model = [ADModel yy_modelWithDictionary:dic];
                [self.ADArray addObject:model];
            }
            ((HompageView *)self.view).ADArray = self.ADArray;
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

- (NSMutableArray *)ADArray{
    if (!_ADArray) {
        _ADArray = [NSMutableArray array];
    }
    return _ADArray;
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
