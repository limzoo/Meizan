//
//  ChargeViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "ChargeViewController.h"
#import "ChargeView.h"
#import "BankModel.h"
#import "UploadVoucherViewController.h"
#import "WXApi.h"
#import "ChargeRecordViewController.h"
#import "PaymentModel.h"
@interface ChargeViewController ()
@property (nonatomic, strong) NSMutableArray *bankArray;
@end

@implementation ChargeViewController
- (instancetype)init{
    self = [super init];
    if(self){
        ChargeView *view = [[ChargeView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    self.title = @"充值页面";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
     [self getPaymentStyle];
}

- (void)getPaymentStyle{
    [MZAFNetwork POST:HOME_URL(@"/sysChannel/query") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dic in [responseObject objectForKey:@"sysChannelList"]) {
                PaymentModel *model = [PaymentModel yy_modelWithDictionary:dic];
                [tempArray addObject:model];
            }
            ((ChargeView *)self.view).paymentStyleArray = tempArray;
            
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)getBankCardList{
    [MZAFNetwork POST:HOME_URL(@"/sysCollectAccountInfo/queryCollectAccountInfo") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.bankArray removeAllObjects];
            for (NSDictionary *dic in [responseObject objectForKey:@"infoList"]) {
                BankModel *model = [BankModel yy_modelWithDictionary:dic];
                [self.bankArray addObject:model];
            }
            ((ChargeView *)self.view).bankArray = self.bankArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)chargeWithType:(NSInteger)type withChargeNum:(CGFloat)num{
    if (type == 1) {
        [MZAFNetwork POST:HOME_URL(@"/acRechargeInfo/rechargeOrders") params:@{@"paymentWay":@"2",@"rechargeAmount":[NSString stringWithFormat:@"%.2f",num]} success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[responseObject objectForKey:@"codeUrl"]]];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            ;
        }];
    }
    if (type == 2) {
        [MZAFNetwork POST:HOME_URL(@"/acRechargeInfo/rechargeOrders") params:@{@"paymentWay":@"1",@"rechargeAmount":[NSString stringWithFormat:@"%.2f",num]} success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
                NSString *orderNo = [[responseObject objectForKey:@"acRechargeInfo"] objectForKey:@"orderNo"];
                 [self payWithOrderNo:orderNo];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            ;
        }];
    }
    
    if (type == 3) {
        [MZAFNetwork POST:HOME_URL(@"/acRechargeInfo/rechargeOrders") params:@{@"paymentWay":@"4",@"rechargeAmount":[NSString stringWithFormat:@"%.2f",num],@"id":[NSString stringWithFormat:@"%ld",((ChargeView *)self.view).currentBankModel.bankCardId.integerValue]} success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
                MyOrderModel *model = [[MyOrderModel alloc] init];
                model.orderId = [responseObject objectForKey:@"orderId"];
                UploadVoucherViewController *vc = [[UploadVoucherViewController alloc] initWithModel:model];
                [self.navigationController pushViewController:vc animated:YES];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            ;
        }];
    }
}

- (void)payWithOrderNo:(NSString *)orderNo{
    NSDictionary *param = @{@"attach":@"用户充值",
                            @"body":@"美赞商城-用户充值",
                            @"outTradeNo":orderNo,
                            @"spbillCreateIp":[Tool getLocalIPAddress:YES],
                            @"tradeType":@"APP",
                            @"payAim":@"2",
                            };
    [MZAFNetwork POST:HOME_URL(@"/wxpay/payForOrder") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"SUCCESS"]) {
            NSMutableDictionary *signDic = [NSMutableDictionary dictionary];
            [signDic setObject:[responseObject objectForKey:@"appid"]      forKey:@"appid"];
            [signDic setObject:[responseObject objectForKey:@"nonce_str"]  forKey:@"noncestr"];
            [signDic setObject:@"Sign=WXPay"          forKey:@"package"];
            [signDic setObject:@"1497114282"      forKey:@"partnerid"];
            [signDic setObject:[responseObject objectForKey:@"prepay_id"]  forKey:@"prepayid"];
            [signDic setObject:[responseObject objectForKey:@"mch_id"]       forKey:@"timestamp"];
            
            // 第二次签名，使用了微信支付工具
            PaySignHandler *handler = [[PaySignHandler alloc]init];
            NSString *sign = [handler createMd5Sign:signDic];
            
            PayReq *request = [[PayReq alloc] init];
            request.partnerId = @"1497114282";
            request.prepayId= [responseObject objectForKey:@"prepay_id"];
            request.package =  @"Sign=WXPay";
            request.nonceStr= [responseObject objectForKey:@"nonce_str"];
            request.timeStamp= ((NSString *)[responseObject objectForKey:@"mch_id"]).intValue;
            request.sign= sign ;
            [WXApi sendReq:request];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *chargeRecord = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:16 title:@"充值记录"];
    [chargeRecord addTarget:self action:@selector(chargeRecord) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:chargeRecord];
}

- (void)chargeRecord{
    [self.navigationController pushViewController:[[ChargeRecordViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)bankArray{
    if (!_bankArray) {
        _bankArray = [NSMutableArray array];
    }
    return _bankArray;
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
