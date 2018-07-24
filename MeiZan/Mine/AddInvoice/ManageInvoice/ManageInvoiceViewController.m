//
//  ManageInvoiceViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ManageInvoiceViewController.h"
#import "ManageInvoiceView.h"

@interface ManageInvoiceViewController ()
@property (nonatomic, strong) NSMutableArray *invoiceArray;
@end

@implementation ManageInvoiceViewController
- (instancetype)initWithModel:(InvoiceModel *)model money:(NSString *)money phoneNum:(NSString *)phoneNumber{
    self = [super init];
    if (self) {
        self.currentModel = model;
        self.money = money;
        self.phoneNumber = phoneNumber;
        ManageInvoiceView *view = [[ManageInvoiceView alloc] initWithFrame:self.view.frame];
        view.money = money;
        view.phoneNumber = phoneNumber;
        view.selectInvoice = ^(InvoiceModel *model) {
            self.selectInvoice(model);
        };
        self.view = view;
    }
    return self;
}

- (void)loadPageData{
    [MZAFNetwork POST:HOME_URL(@"/userInvoice/queryInvoiceList") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.invoiceArray removeAllObjects];
            int i = 0;
            for (NSDictionary *dic in [responseObject objectForKey:@"infoList"]) {
                InvoiceModel *model = [InvoiceModel yy_modelWithDictionary:dic];
                [self.invoiceArray addObject:model];
                if (model.invoiceId.intValue == self.currentModel.invoiceId.intValue) {
                    ((ManageInvoiceView *) self.view).selectIndex = i;
                }
                i++;
            }
            ((ManageInvoiceView *)self.view).invoiceArray = self.invoiceArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)deleteInvoice:(NSString *)invoiceId{
    [MZAFNetwork POST:HOME_URL(@"/userInvoice/deleteInvoice") params:@{@"id":invoiceId} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self loadPageData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    self.title = @"请选择发票抬头";
    [self loadPageData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)invoiceArray{
    if (!_invoiceArray) {
        _invoiceArray = [NSMutableArray array];
    }
    return _invoiceArray;
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
