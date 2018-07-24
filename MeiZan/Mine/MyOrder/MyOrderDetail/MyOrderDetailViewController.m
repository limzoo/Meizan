//
//  MyOrderDetailViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/24.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyOrderDetailViewController.h"
#import "MyOrderDetailView.h"
#import "MyOrderModel.h"
@interface MyOrderDetailViewController ()
@property (nonatomic, strong) MyOrderModel *orderModel;
@end

@implementation MyOrderDetailViewController
- (instancetype)initWithModel:(MyOrderModel *)orderModel{
    self = [super init];
    if (self) {
        self.orderModel = orderModel;
        MyOrderDetailView *view = [[MyOrderDetailView alloc] initWithFrame:self.view.frame];
        view.orderModel = orderModel;
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"订单详情";
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadPageData];
}

- (void)loadPageData{
    [MZAFNetwork POST:HOME_URL(@"/orderInfo/queryOrderDetails") params:@{@"id":self.orderModel.orderId} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            ((MyOrderDetailView *)self.view).responseObject = responseObject;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)updateOrder:(MyOrderModel *)order status:(NSInteger)status{
    NSDictionary *param = @{@"id":order.ID,
                            @"orderStatus":[NSString stringWithFormat:@"%ld",status]
                            };
    [MZAFNetwork POST:HOME_URL(@"/orderInfo/updateOrderStatus") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.navigationController popViewControllerAnimated:YES];
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
