//
//  MerchandiseViewController.m
//  JingXuan
//
//  Created by sfs on 2017/12/10.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MerchandiseViewController.h"
#import "MerchandiseSelectTypeViewController.h"
#import "MerchandiseView.h"
#import "MerchandiseDetailModel.h"
#import "MerchandiseTypeModel.h"
#import "MerchandiseUserComment.h"
#import "ImageModel.h"
@interface MerchandiseViewController ()
@property (nonatomic, strong) UISegmentedControl *segmentCtrl;
@property (nonatomic, strong) NSString *merchandiseID;
@property (nonatomic, strong) MerchandiseDetailModel *model;
@property (nonatomic, strong) NSMutableArray *typeModelArray;
@property (nonatomic, strong) NSMutableArray *goodsImageArray;
@property (nonatomic, strong) MerchandiseUserComment *comment;
@end

@implementation MerchandiseViewController
- (instancetype)initWithMerchandiseID:(NSString *)merchandiseID{
    self = [super init];
    if (self) {
        MerchandiseView *view = [[MerchandiseView alloc] initWithFrame:self.view.frame];
        self.view = view;
        self.segmentCtrl = [[UISegmentedControl alloc] initWithItems:@[@"商品",@"详情"]];
        [self.segmentCtrl addTarget:view action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        self.segmentCtrl.selectedSegmentIndex = 0;
        self.segmentCtrl.tintColor = STYLECOLOR;
        
        self.segmentCtrl.frame = CGRectMake(0, 0, 152, 28);
        self.navigationItem.titleView = self.segmentCtrl;
        self.merchandiseID = merchandiseID;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self getPageDataWithMerchandiseID:self.merchandiseID];
    [self getShopCartNum];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getPageDataWithMerchandiseID:(NSString *)merchandiseID{
    [MZAFNetwork POST:HOME_URL(@"/shopGoodsInfo/queryGoodsDetails") params:@{@"id":self.merchandiseID} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.typeModelArray removeAllObjects];
            if ([responseObject objectForKey:@"sku1"]) {
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *dic in [responseObject objectForKey:@"sku1"]) {
                    [array addObject:[MerchandiseTypeModel yy_modelWithDictionary:dic]];
                }
                [self.typeModelArray addObject:array];
            }
            if ([responseObject objectForKey:@"sku2"]) {
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *dic in [responseObject objectForKey:@"sku2"]) {
                    [array addObject:[MerchandiseTypeModel yy_modelWithDictionary:dic]];
                }
                [self.typeModelArray addObject:array];
            }
            [self.goodsImageArray removeAllObjects];
            for (NSDictionary *dic in [responseObject objectForKey:@"goodsImages"]) {
                ImageModel *imageModel = [ImageModel yy_modelWithDictionary:dic];
                [self.goodsImageArray addObject:imageModel];
            }
            
            MerchandiseDetailModel *model = [[MerchandiseDetailModel alloc] init];
            model = [MerchandiseDetailModel yy_modelWithDictionary:[responseObject objectForKey:@"goodsDetails"]];
            model.count = [responseObject objectForKey:@"count"];
            model.rate = [responseObject objectForKey:@"rate"];
            model.salesCount = [responseObject objectForKey:@"salesCount"];
            ((MerchandiseView *)self.view).goodsImagesArray = self.goodsImageArray;
            ((MerchandiseView *)self.view).model = model;
            self.comment = [MerchandiseUserComment yy_modelWithDictionary:[responseObject objectForKey:@"goodsAppraises"]];
            ((MerchandiseView *)self.view).comment = self.comment;
            ((MerchandiseView *)self.view).typeModelArray = self.typeModelArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)getShopCartNum{
    [MZAFNetwork POST:HOME_URL(@"/shopCart/queryShopCartCount") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
            ((MerchandiseView *)self.view).shopCartNumLabel.text = [responseObject objectForKey:@"count"];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (NSMutableArray *)typeModelArray{
    if (!_typeModelArray) {
        _typeModelArray = [NSMutableArray array];
    }
    return _typeModelArray;
}

- (NSMutableArray *)goodsImageArray{
    if (!_goodsImageArray) {
        _goodsImageArray = [NSMutableArray array];
    }
    return _goodsImageArray;
}

- (MerchandiseUserComment *)comment{
    if (!_comment) {
        _comment = [[MerchandiseUserComment alloc] init];
    }
    return _comment;
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
