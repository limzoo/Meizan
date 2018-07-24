
//
//  AddInvoiceViewController.m
//  JingXuan
//
//  Created by sfs on 2017/12/18.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "AddInvoiceViewController.h"
#import "AddInvoiceView.h"
@interface AddInvoiceViewController ()

@end

@implementation AddInvoiceViewController
- (instancetype)initWithMoney:(NSString *)money phoneNum:(NSString *)phoneNumber{
    self = [super init];
    if (self) {
        self.money = money;
        self.phoneNumber = phoneNumber;
        AddInvoiceView *view = [[AddInvoiceView alloc] initWithFrame:self.view.frame];
        view.money = self.money;
        view.phoneNumber = self.phoneNumber;
        self.view = view;
    }
    return  self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"添加发票抬头";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)uploadInvoiceWithId:(NSString *)invoiceId invoiceName:(NSString *)invoiceName invoiceType:(NSString *)invoiceType identifyNumber:(NSString *)identifyNumber isDefault:(NSString *)isDefault content:(NSString *)content{
    NSDictionary *param = @{@"id":invoiceId,
                            @"invoiceName":invoiceName,
                            @"invoiceType":invoiceType,
                            @"identifyNumber":identifyNumber,
                            @"isDefault":isDefault,
                            @"content":content,
                            };
    [MZAFNetwork POST:HOME_URL(@"/userInvoice/saveInvoiceInfo") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
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
