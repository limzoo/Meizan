//
//  AddAddressViewController.m
//  JingXuan
//
//  Created by sfs on 2017/12/15.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AddAddress.h"
@interface AddAddressViewController ()

@end

@implementation AddAddressViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        AddAddress *view = [[AddAddress alloc] init];
        self.view = view;
    }
    return self;
}
- (void)setModel:(UserAddressModel *)model{
    _model = model;
    ((AddAddress *)self.view).model = model;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"新建地址";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addAddressWithDataDic:(NSDictionary *)dataDic {
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dataDic];
    [tempDic removeObjectForKey:@"createTime"];
    [MZAFNetwork POST:HOME_URL(@"/userDeliveryAddress/saveAddressInfo") params:tempDic success:^(NSURLSessionDataTask *task, id responseObject) {
        [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
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
