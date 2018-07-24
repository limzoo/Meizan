//
//  MyOrderViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderView.h"

@interface MyOrderViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger initialIndex;
@end

@implementation MyOrderViewController
- (instancetype)initWithIndex:(NSInteger)index{
    self = [super init];
    if (self) {
        self.page = 1;
        MyOrderView *view = [[MyOrderView alloc] initWithFrame:self.view.frame];
        view.currentIndex = index;
        self.initialIndex = index;
        self.view = view;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self loadPageDataWithIndex:self.initialIndex page:1];

    self.title = @"我的订单";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPageDataWithIndex:(NSInteger)index page:(NSInteger)page{
    self.page = page;
    self.initialIndex = index;
    NSDictionary *param;
    switch (self.initialIndex) {
        case 0:{
            param = @{@"orderStatus":[NSNull null], @"page":[NSNumber numberWithInteger:self.page],
                                    };
            break;
        }
        case 1:{
            param = @{@"orderStatus":@"0",
                                    @"page":[NSNumber numberWithInteger:self.page],
                                    };
            break;
        }
        case 2:{
            param = @{@"orderStatus":@"6",
                      @"page":[NSNumber numberWithInteger:self.page],
                      };
            break;
        }
        case 3:{
            param = @{@"orderStatus":@"1",
                      @"page":[NSNumber numberWithInteger:self.page],
                      };
            break;
        }
        case 4:{
            param = @{@"orderStatus":@"3",
                      @"page":[NSNumber numberWithInteger:self.page],
                      };
            break;
        }
        case 5:{
            param = @{@"orderStatus":@"2",
                      @"page":[NSNumber numberWithInteger:self.page],
                      };
            break;
        }
        default:
            break;
    }
    [MZAFNetwork POST:HOME_URL(@"/orderInfo/queryAllOrder") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            if (page == 1) {
                [self.dataArray removeAllObjects];
            }
            for (NSDictionary *dic in [responseObject objectForKey:@"orderlist"]) {
                MyOrderModel *model = [MyOrderModel yy_modelWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            ((MyOrderView *)self.view).dataArray = self.dataArray;
            
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
//orderStatus    string    是    5：取消订单，3：确认收货
- (void)updateOrder:(MyOrderModel *)order status:(NSInteger)status{
    NSDictionary *param = @{@"id":order.ID,
                            @"orderStatus":[NSString stringWithFormat:@"%ld",status]
                            };
    [MZAFNetwork POST:HOME_URL(@"/orderInfo/updateOrderStatus") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            if (status == 5) {
                [self loadPageDataWithIndex:1 page:1];
            }else if (status == 3){
                [self loadPageDataWithIndex:5 page:1];
            }
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray ) {
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
