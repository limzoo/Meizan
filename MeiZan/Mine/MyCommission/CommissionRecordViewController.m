//
//  CommissionRecordViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "CommissionRecordViewController.h"
#import "CommissionRecordView.h"
#import "TradeRecordModel.h"
@interface CommissionRecordViewController ()
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation CommissionRecordViewController
- (instancetype)initWithType:(NSInteger)type{
    self = [super init];
    if (self) {
        self.type = type;
        CommissionRecordView *view = [[CommissionRecordView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadPageData];
    if (self.type == 1) {
        self.title = @"转出记录";
    }
    if (self.type == 2) {
        self.title = @"佣金明细";
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
/*
 transferType    number    否    交易类型：1.充值 2.提现 3.支付 4.奖励 5.佣金转出        5
 accountType    number    否    账户类型(1-余额账户2-积分账户 3-佣金账户)        3
 page    number    是    当前页        1
 limit*/
- (void)loadPageData{
    NSString *transferType = @"";
    if (self.type == 1) {
        transferType = @"5";
    }else{
        transferType = @"4";
    }
    NSDictionary *param = @{@"transferType":transferType,
                            @"accountType":@"3",
                            @"page":@"1",
                            @"limit":@"999"
                            };
    [MZAFNetwork POST:HOME_URL(@"/acTransactionFlow/queryAcTransactionFlow") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.dataArray removeAllObjects];
            for (NSDictionary *dic in [responseObject objectForKey:@"acTransactionFlowList"]) {
                TradeRecordModel *model = [TradeRecordModel yy_modelWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            ((CommissionRecordView *)self.view).dataArray = self.dataArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
