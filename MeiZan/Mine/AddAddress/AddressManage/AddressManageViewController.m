//
//  AddressManageViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "AddressManageViewController.h"
#import "AddressManageView.h"
#import "UserAddressModel.h"
@interface AddressManageViewController ()

@end

@implementation AddressManageViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        AddressManageView *view = [[AddressManageView alloc] initWithFrame:self.view.frame];
        self.view = view;
        view.backAddressModel = ^(UserAddressModel *model) {
            self.backAddressModel(model);
        };
    }
    return self;
}

- (void)loadPageData{
    [MZAFNetwork POST:HOME_URL(@"/userDeliveryAddress/queryAddressList") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            NSMutableArray *dataArray = [NSMutableArray array];
            for (NSDictionary *dic in [responseObject objectForKey:@"infoList"]) {
                UserAddressModel *model = [UserAddressModel yy_modelWithDictionary:dic];
                [dataArray addObject:model];
            }
            ((AddressManageView *)self.view).dataArray = dataArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}


- (void)deleteAddress:(UserAddressModel *)model{
   [ MZAFNetwork POST:HOME_URL(@"/userDeliveryAddress/deleteAddress") params:@{@"id":[NSString stringWithFormat:@"%ld",model.addressId]} success:^(NSURLSessionDataTask *task, id responseObject) {
       if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
           [Tool showMessage:@"操作成功" duration:3];
           [self loadPageData];
       }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadPageData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"地址管理";
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
