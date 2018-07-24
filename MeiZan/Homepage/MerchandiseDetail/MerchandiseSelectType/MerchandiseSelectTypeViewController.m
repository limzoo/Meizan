//
//  MerchandiseSelectTypeViewController.m
//  JingXuan
//
//  Created by sfs on 2017/12/13.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MerchandiseSelectTypeViewController.h"
#import "MerchandiseSelectType.h"
#import "MerchandiseView.h"
#import "MerchandiseSelectResultModel.h"
@interface MerchandiseSelectTypeViewController ()
@property (nonatomic, strong) MerchandiseSelectResultModel *selectModel;
@end

@implementation MerchandiseSelectTypeViewController
- (instancetype)initWithType:(NSInteger)type{
    self = [super init];
    if (self) {
        MerchandiseSelectType *view  = [[MerchandiseSelectType alloc] init];
        view.type = type;
        self.view = view;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDataArray:(NSArray *)dataArray{
    ((MerchandiseSelectType *)self.view).dataArray = dataArray;
}

- (void)setModel:(MerchandiseDetailModel *)model{
    _model = [[MerchandiseDetailModel alloc] init];
    _model = model;
    ((MerchandiseSelectType *)self.view).model = model;
}

- (void)addToShopCartWithNumber:(NSInteger)num{
    if (!self.selectModel) {
        [Tool showMessage:@"请选择商品规格" duration:3];
        return;
    }
    NSDictionary *dic = @{@"skuId":[NSNumber numberWithLong: self.selectModel.selectMerchandiseId],
                          @"number":[NSNumber numberWithInteger:num]
                          };
    [MZAFNetwork POST:HOME_URL(@"/shopCart/insert") params:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
             [[NSNotificationCenter defaultCenter] postNotificationName:@"removeSelectPage" object:nil userInfo:dic];
        }
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0002"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"removeSelectPage" object:nil];
        }
         [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)getMerchandiseMessageWithSpecsId:(NSString *)specsId goodsId:(NSNumber *)goodsId{
    NSDictionary *param = @{@"specsId":specsId,
                            @"goodsId":goodsId
                            };
    [MZAFNetwork POST:HOME_URL(@"/shopGoodsInfo/selectSkuGoodsInfo") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            self.selectModel = [MerchandiseSelectResultModel yy_modelWithDictionary:[responseObject objectForKey:@"shopGoodsSku"]];
            ((MerchandiseSelectType *)self.view).selectModel = self.selectModel;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)changeMerchandise:(NSString *)modelId  skuId:(NSString *)skuId selectNum:(NSInteger)num{
    NSDictionary *param = @{@"id":modelId,
                            @"number":[NSNumber numberWithLong:num],
                            @"skuId":skuId,
                            };
    [MZAFNetwork POST:HOME_URL(@"/shopCart/updateShopCart") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [Tool showMessage:@"修改成功" duration:3];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"removeSelectPage" object:nil];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)setShopCardId:(NSString *)shopCardId{
    _shopCardId = shopCardId;
    ((MerchandiseSelectType *)self.view).shopCartId = shopCardId;
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
