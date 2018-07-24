//
//  ShopCartViewController.m
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "ShopCartViewController.h"
#import "ShopCartView.h"
#import "ShopCartModel.h"
#import "MerchandiseTypeModel.h"
#import "MerchandiseDetailModel.h"
@interface ShopCartViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIBarButtonItem *editBarButton;
@property (nonatomic, strong) NSMutableArray *typeModelArray;
@end

@implementation ShopCartViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        self.view = [[ShopCartView alloc] initWithFrame:self.view.frame];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.dataArray removeAllObjects];
    [self loadPageData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"购物车";
    UIButton *editButton = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:16 title:@"编辑"];
    editButton.frame = CGRectMake(0, 0, 80, 44);
    editButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [editButton addTarget:self action:@selector(enterEditState) forControlEvents:UIControlEventTouchUpInside];
    self.editBarButton = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = self.editBarButton;
}

- (void)enterEditState{
    ((ShopCartView *)self.view).isEdit =  !((ShopCartView *)self.view).isEdit;
    if (((ShopCartView *)self.view).isEdit) {
        UIButton *editButton = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:16 title:@"完成"];
        editButton.frame = CGRectMake(0, 0, 80, 44);
        editButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [editButton addTarget:self action:@selector(enterEditState) forControlEvents:UIControlEventTouchUpInside];
        self.editBarButton = [[UIBarButtonItem alloc] initWithCustomView:editButton];
        self.navigationItem.rightBarButtonItem = self.editBarButton;
    }else{
        UIButton *editButton = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:16 title:@"编辑"];
        editButton.frame = CGRectMake(0, 0, 80, 44);
        editButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [editButton addTarget:self action:@selector(enterEditState) forControlEvents:UIControlEventTouchUpInside];
        self.editBarButton = [[UIBarButtonItem alloc] initWithCustomView:editButton];
        self.navigationItem.rightBarButtonItem = self.editBarButton;
    }
    
    [self loadPageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPageData{
    [MZAFNetwork POST:HOME_URL(@"/shopCart/query") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.dataArray removeAllObjects];
            for (NSDictionary *dic in [responseObject objectForKey:@"shopCartList"]) {
                ShopCartModel *model = [ShopCartModel yy_modelWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            ((ShopCartView *)self.view).dataArray = self.dataArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)deleteItemFromShopCartWithId:(NSString *)Id row:(NSInteger)row {
    NSDictionary *param = @{@"id":Id};
    [MZAFNetwork POST:HOME_URL(@"/shopCart/delete") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            NSMutableDictionary *tempDict = ((ShopCartView *)self.view).selectMerchandiseDict;
            for (int i = 0; i < [tempDict allKeys].count; i ++) {
                NSString *key = [tempDict allKeys][i];
                if (key.integerValue > row) {
                    [tempDict setObject:[tempDict objectForKey:key] forKey:[NSString stringWithFormat:@"%ld",key.integerValue - 1]];
                    [tempDict removeObjectForKey:key];
                }
            }
            ((ShopCartView *)self.view).selectMerchandiseDict = tempDict;
            [self.dataArray removeAllObjects];
            [self loadPageData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)deleteSelectItemFromShopCartWithId:(NSString *)Id{
    NSDictionary *param = @{@"id":Id};
    [MZAFNetwork POST:HOME_URL(@"/shopCart/delete") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            ((ShopCartView *)self.view).selectMerchandiseDict = nil;
            [self.dataArray removeAllObjects];
            [self loadPageData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)getPageDataWithCartId:(NSString *)cartId skuId:(NSString *)skuId goodsId:(NSString *)goodsId number:(NSString *)number shopCartId:(NSString *)shopCartId{
    NSDictionary *param = @{@"cartId":cartId,@"skuId":skuId,@"goodsId":goodsId,@"number":number};
    [MZAFNetwork POST:HOME_URL(@"/shopCart/selectSpecsInfo") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
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
            
            ((ShopCartView*)self.view).selectVC = [[MerchandiseSelectTypeViewController alloc] initWithType:2];
            //    self.selectVC.dataArray = self.typeModelArray;
            ((ShopCartView*)self.view).selectTypeView = [[UIView alloc] init];
            ((ShopCartView*)self.view).selectTypeView.backgroundColor = [UIColor whiteColor];
            [((ShopCartView*)self.view).masksView addSubview:((ShopCartView*)self.view).selectTypeView];
            [((ShopCartView*)self.view).selectTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.trailing.bottom.mas_equalTo(((ShopCartView*)self.view).masksView);
                make.height.mas_equalTo(0);
            }];
            
            [((ShopCartView*)self.view).selectTypeView addSubview:((ShopCartView*)self.view).selectVC.view];
            [((ShopCartView*)self.view).selectVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.top.bottom.trailing.mas_equalTo(((ShopCartView*)self.view).selectTypeView);
            }];
            
            
            MerchandiseDetailModel *model = [[MerchandiseDetailModel alloc] init];
            model = [MerchandiseDetailModel yy_modelWithDictionary:[responseObject objectForKey:@"goodsDetails"]];
            model.shopCartNum = [responseObject objectForKey:@"number"];
            ((ShopCartView *)self.view).selectVC.dataArray = self.typeModelArray;
            ((ShopCartView *)self.view).selectVC.shopCardId = shopCartId;
            [[UIApplication sharedApplication].keyWindow bringSubviewToFront: ((ShopCartView *)self.view).masksView];
            [ ((ShopCartView *)self.view).masksView setHidden:NO];
            [ ((ShopCartView *)self.view) bringSubviewToFront: ((ShopCartView *)self.view).selectTypeView];
            [ ((ShopCartView *)self.view) setNeedsUpdateConstraints];
            [ ((ShopCartView *)self.view) updateConstraintsIfNeeded];
            [ ((ShopCartView *)self.view).selectTypeView
             mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(356);
            }];
            ((ShopCartView *)self.view).selectVC.model = model;
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                ((ShopCartView *)self.view).masksView.alpha = 1;
                [ ((ShopCartView *)self.view) layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)changeMerchandise:(ShopCartModel *)model selectNum:(NSInteger)num{
    NSDictionary *param = @{@"id":model.ID,
                            @"number":[NSNumber numberWithLong:num],
                            @"skuId":model.SKU_ID,
                            };
    [MZAFNetwork POST:HOME_URL(@"/shopCart/updateShopCart") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)typeModelArray{
    if (!_typeModelArray) {
        _typeModelArray = [NSMutableArray array];
    }
    return _typeModelArray;
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
