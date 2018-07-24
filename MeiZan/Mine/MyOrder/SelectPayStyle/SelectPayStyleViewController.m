//
//  SelectPayStyleViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "SelectPayStyleViewController.h"
#import "SelectPayStyleView.h"
#import "WXApi.h"
#import "PaymentModel.h"
#import "BankModel.h"
#import "UploadVoucherViewController.h"
@interface SelectPayStyleViewController ()
@property (nonatomic, strong) NSMutableArray *paymentArray;
@property (nonatomic, strong) MyOrderModel *orderModel;
@property (nonatomic, strong) NSMutableArray *bankArray;

@end

@implementation SelectPayStyleViewController
- (instancetype)initWithOrderModel:(MyOrderModel *)orderModel{
    self = [super init];
    if (self) {
        self.orderModel = orderModel;
        SelectPayStyleView *view = [[SelectPayStyleView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self getPaymentStyle];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"选择支付方式";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getPaymentStyle{
    [MZAFNetwork POST:HOME_URL(@"/sysChannel/query") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dic in [responseObject objectForKey:@"sysChannelList"]) {
                PaymentModel *model = [PaymentModel yy_modelWithDictionary:dic];
                [tempArray addObject:model];
            }
            ((SelectPayStyleView *)self.view).paymentArray = tempArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)payWithPayType:(NSInteger)payType{
    if (payType == 1) {
        NSDictionary *param = @{@"attach":@"购买商品",
                                @"body":@"美赞商城-购买商品",
                                @"outTradeNo":self.orderModel.ORDER_NO,
                                @"spbillCreateIp":[Tool getLocalIPAddress:YES],
                                @"tradeType":@"APP",
                                @"payAim":@"1",
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
    if (payType == 2) {
        [MZAFNetwork POST:HOME_URL(@"/orderInfo/payOrder") params:@{@"orderId":self.orderModel.orderId,@"payType":[NSString stringWithFormat:@"%ld",payType]} success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"跳转到支付页面..." message:nil preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action1 =[UIAlertAction actionWithTitle:@"已完成支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    ;
                }];
                UIAlertAction *action2 =[UIAlertAction actionWithTitle:@"未完成支付" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    ;
                }];
                [alertVC addAction:action1];
                [alertVC addAction:action2];
                [self presentViewController:alertVC animated:YES completion:^{
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[responseObject objectForKey:@"codeUrl"]]];
                }];
                
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            ;
        }];
    }
    if (payType == 3) {
        [MZAFNetwork POST:HOME_URL(@"/orderInfo/payOrder") params:@{@"orderId":self.orderModel.orderId,@"payType":[NSString stringWithFormat:@"%ld",payType]} success:^(NSURLSessionDataTask *task, id responseObject) {
              [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3 atCenter:YES];
            if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
                [((SelectPayStyleView *)self.view).inputPasswordView.passwordField resignFirstResponder];
                 [self.navigationController popViewControllerAnimated:YES];
                [UIView animateWithDuration:0.7 animations:^{
                        ((SelectPayStyleView *)self.view).maskView.hidden = YES;
                        ((SelectPayStyleView *)self.view).inputPasswordView.hidden = YES;
                    } completion:^(BOOL finished) {
                    }];
            }else{
                 [((SelectPayStyleView *)self.view).inputPasswordView.passwordField resignFirstResponder];
                [UIView animateWithDuration:0.7 animations:^{
                    ((SelectPayStyleView *)self.view).maskView.hidden = YES;
                    ((SelectPayStyleView *)self.view).inputPasswordView.hidden = YES;
                } completion:^(BOOL finished) {
                }];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            ;
        }];
    }
    if (payType == 4) {
        UploadVoucherViewController *vc = [[UploadVoucherViewController alloc] initWithModel:self.orderModel];
        vc.hidesBottomBarWhenPushed = YES;
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray: self.navigationController.viewControllers];
        [tempArray removeLastObject];
        [tempArray addObject:vc];
        [self.navigationController setViewControllers:tempArray animated:YES];
    }
}

- (void)verifyPayPassword:(NSString *)password{
    [MZAFNetwork POST:HOME_URL(@"/userInfo/verifyPayPassword") params:@{@"payPassword":password} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self payWithPayType:3];
        }else if([[responseObject objectForKey:@"return_code"] isEqualToString:@"0001"]){
            [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3 atCenter:YES];
            [((SelectPayStyleView *)self.view).inputPasswordView cleanPassword];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
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
            ((SelectPayStyleView *)self.view).bankArray = self.bankArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
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
