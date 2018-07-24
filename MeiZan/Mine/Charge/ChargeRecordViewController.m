//
//  ChargeRecordViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/31.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ChargeRecordViewController.h"
#import "ChargeRecordModel.h"
#import "ChargeRecordView.h"
@interface ChargeRecordViewController ()
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation ChargeRecordViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        ChargeRecordView *view = [[ChargeRecordView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.page = 1;
    [self loadPageData];
}
- (void)loadPageData{
    [MZAFNetwork POST:HOME_URL(@"/acRechargeInfo/queryRechargeOrderInfo") params:@{@"page":[NSNumber numberWithInteger:self.page]} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            for (NSDictionary *dic in [responseObject objectForKey:@"orderlist"]) {
                ChargeRecordModel *model =  [ChargeRecordModel yy_modelWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            ((ChargeRecordView *)self.view).dataArray = self.dataArray;
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
