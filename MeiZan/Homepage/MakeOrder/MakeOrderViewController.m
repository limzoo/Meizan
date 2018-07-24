//
//  MakeOrderViewController.m
//  JingXuan
//
//  Created by sfs on 2017/12/14.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MakeOrderViewController.h"
#import "MakeOrderView.h"
#import "UserAddressModel.h"
#import "BankModel.h"
#import "WKWebViewController.h"
#import "WXApi.h"
#import "SetPayPasswordViewController.h"
#import "MyOrderViewController.h"
#import "UploadVoucherViewController.h"
#import "PaymentModel.h"
@interface MakeOrderViewController ()<WXApiDelegate>
@property (nonatomic, strong) NSMutableArray *addressArray;
@property (nonatomic, strong) NSMutableArray *bankArray;
@property (nonatomic, strong) NSMutableArray *invoiceArray;
@property (nonatomic, strong) NSString *skuId;
@property (nonatomic, strong) NSString *number;
@property (nonatomic, strong) NSString *cartId;
@property (nonatomic, strong) NSString *orderId;
@end

@implementation MakeOrderViewController
- (instancetype)initWithCartId:(NSString *)cartId{
    self = [super init];
    if (self) {
        MakeOrderView *view = [[MakeOrderView alloc] initWithFrame:self.view.frame];
        self.view = view;
        self.skuId = @"";
        self.number = @"";
        self.cartId = cartId;
    }
    return self;
}
- (instancetype)initWithSkuId:(NSString *)skuId number:(NSString *)number{
    self = [super init];
    if (self) {
        MakeOrderView *view = [[MakeOrderView alloc] initWithFrame:self.view.frame];
        self.view = view;
        self.skuId = skuId;
        self.number = number;
        self.cartId = @"";
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (((MakeOrderView *)self.view).currentAddressModel == nil) {
        [self loadUserAddress];
        [self preMakeOrder];
        [self loadInvoicePage];
        [self getPaymentStyle];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"填写订单";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXSuccessPay) name:@"successPay" object:nil];
}
- (void)WXSuccessPay{
    MyOrderViewController *vc =[[MyOrderViewController alloc] initWithIndex:3];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadUserAddress{
    [MZAFNetwork POST:HOME_URL(@"/userDeliveryAddress/queryAddressList") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.addressArray removeAllObjects];
            for (NSDictionary *dic in [responseObject objectForKey:@"infoList"]) {
                UserAddressModel *model = [UserAddressModel yy_modelWithDictionary:dic];
                [self.addressArray addObject:model];
            }
            ((MakeOrderView *)self.view).userAddressArray = self.addressArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)loadInvoicePage{
    [MZAFNetwork POST:HOME_URL(@"/userInvoice/queryInvoiceList") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self.invoiceArray removeAllObjects];
            for (NSDictionary *dic in [responseObject objectForKey:@"infoList"]) {
                InvoiceModel *model = [InvoiceModel yy_modelWithDictionary:dic];
                [self.invoiceArray addObject:model];
            }
            ((MakeOrderView *)self.view).invoiceArray = self.invoiceArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
/*cartId    string    是    购物车id 多个id用，隔开 如：1,2        1
 addressId    string    是    地址id        3
 invoiceId    string    否    发票id
 device_type    string    是    订单来源订单来源(ios;android)        android
 orderRemarks    string    否    订单备注        呵呵
 paymentWay    string    是    支付方式(1-微信2-支付宝3-余额支付4-线下打款)        1
 deliveryTime    string    否    期望收货日期时间        2018-01-05
 collectId*/
- (void)makeOrderWithCartId:(NSString *)cartId addressId:(NSString *)addressId invoiceId:(NSString *)invoiceId paymentWay:(NSInteger)paymentWay collectId:(NSString *)collectId deliveryTime:(NSString *)deliveryTime{
    if (self.cartId != nil && self.cartId.length > 0) {
        cartId = self.cartId;
    }
    NSDictionary *param = @{
                          @"cartId":cartId,
                          @"addressId":addressId,
                          @"invoiceId":invoiceId,
                          @"device_type":@"ios",
                          @"paymentWay":[NSString stringWithFormat:@"%ld",paymentWay],
                          @"deliveryTime":deliveryTime,
                          @"collectId":collectId,
                          };
    [MZAFNetwork POST:HOME_URL(@"/orderInfo/insertOrderInfo") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            self.orderId = [NSString stringWithFormat:@"%ld",((NSNumber *)[responseObject objectForKey:@"orderId"]).integerValue];
            if (paymentWay == 1) {
                NSString *orderNo = [[responseObject objectForKey:@"orderInfo"] objectForKey:@"orderNo"];
                [self payWithOrderNo:orderNo payType:paymentWay];
            }else if (paymentWay == 4){
                MyOrderModel *model = [[MyOrderModel alloc] init];
                model.orderId = [responseObject objectForKey:@"orderId"];
                UploadVoucherViewController *vc = [[UploadVoucherViewController alloc] initWithModel:model];
                vc.hidesBottomBarWhenPushed = YES;
                NSMutableArray *tempArray = [NSMutableArray arrayWithArray: self.navigationController.viewControllers];
                [tempArray removeLastObject];
                [tempArray addObject:vc];
                [self.navigationController setViewControllers:tempArray animated:YES];
            }
            else{
                [self payWithOrderId:self.orderId payType:paymentWay];
            }
        }else{
            [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)payWithOrderNo:(NSString *)orderNo payType:(NSInteger)payType{
    NSDictionary *param = @{@"attach":@"购买商品",
                            @"body":@"美赞商城-购买商品",
                            @"outTradeNo":orderNo,
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


- (void)payWithOrderId:(NSString *)orderId payType:(NSInteger)payType{
    if (payType == 2) {
        [MZAFNetwork POST:HOME_URL(@"/orderInfo/payOrder") params:@{@"orderId":orderId,@"payType":[NSString stringWithFormat:@"%ld",payType]} success:^(NSURLSessionDataTask *task, id responseObject) {
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
        [MZAFNetwork POST:HOME_URL(@"/orderInfo/payOrder") params:@{@"orderId":orderId,@"payType":[NSString stringWithFormat:@"%ld",payType]} success:^(NSURLSessionDataTask *task, id responseObject) {
            if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
                [((MakeOrderView *)self.view).inputPasswordView.passwordField resignFirstResponder];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:0.7 animations:^{
                        ((MakeOrderView *)self.view).maskView.hidden = YES;
                        ((MakeOrderView *)self.view).inputPasswordView.hidden = YES;
                    }];
                });
                MyOrderViewController *vc =[[MyOrderViewController alloc] initWithIndex:3];
                vc.hidesBottomBarWhenPushed = YES;
                NSMutableArray *tempArray = [NSMutableArray arrayWithArray: self.navigationController.viewControllers];
                [tempArray removeLastObject];
                [tempArray addObject:vc];
                [self.navigationController setViewControllers:tempArray animated:YES];
                
            }else{
            [((MakeOrderView *)self.view) resignFirstResponder];
                ((MakeOrderView *)self.view).maskView.hidden = YES;
                ((MakeOrderView *)self.view).inputPasswordView.hidden = YES;
          [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
            }
        } fail:^(NSURLSessionDataTask *task, NSError *error) {
            ;
        }];
    }
}
- (NSMutableArray *)addressArray{
    if (!_addressArray) {
        _addressArray = [NSMutableArray array];
    }
    return _addressArray;
}
- (void)preMakeOrder{
    /*cartId    string    是    购物车下单必传 购物车id，多个购物车id由,隔开 如:1,2
     skuId    string    是    立即购买必传 规格商品id        2
     number    string    是    立即购买必传 购买数量        10
     invoiceId    string    否    选择发票抬头必传 发票id
     invoiceName*/
    NSDictionary *param = @{
                            @"cartId":self.cartId,
                            @"skuId":self.skuId,
                            @"number":self.number,
                            };
    [MZAFNetwork POST:HOME_URL(@"/shopGoodsInfo/selectGoodsOrderInfo") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            PreOrderModel *model = [PreOrderModel yy_modelWithDictionary:responseObject];
            ((MakeOrderView *)self.view).model = model;
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
            ((MakeOrderView *)self.view).bankArray = self.bankArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)getPaymentStyle{
    [MZAFNetwork POST:HOME_URL(@"/sysChannel/query") params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dic in [responseObject objectForKey:@"sysChannelList"]) {
                PaymentModel *model = [PaymentModel yy_modelWithDictionary:dic];
                [tempArray addObject:model];
            }
            ((MakeOrderView *)self.view).paymentStyleArray =  tempArray;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (void)verifyPayPassword:(NSString *)password{
    [MZAFNetwork POST:HOME_URL(@"/userInfo/verifyPayPassword") params:@{@"payPassword":password} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [self makeOrderWithCartId:[NSString stringWithFormat:@"%ld", ((MakeOrderView *)self.view).model.cartId.integerValue] addressId:[NSString stringWithFormat:@"%ld", ((MakeOrderView *)self.view).currentAddressModel.addressId] invoiceId:[NSString stringWithFormat:@"%ld", ((MakeOrderView *)self.view).currentInvoiceModel.invoiceId.integerValue] paymentWay:3 collectId:[NSString stringWithFormat:@"%ld", ((MakeOrderView *)self.view).selectBankModel.bankCardId.integerValue] deliveryTime:((MakeOrderView *)self.view).deliverTime];
        }else if([[responseObject objectForKey:@"return_code"] isEqualToString:@"0001"]){
            [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3 atCenter:YES];
            [((MakeOrderView *)self.view).inputPasswordView cleanPassword];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (void)setMerchandiseArray:(NSMutableArray<MerchandiseSelectResultModel *> *)merchandiseArray{
    _merchandiseArray = merchandiseArray;
    ((MakeOrderView *)self.view).merchandiseArray = merchandiseArray;
}
- (void)setCartArrray:(NSMutableArray *)cartArrray{
    _cartArrray = cartArrray;
}
- (NSMutableArray *)bankArray{
    if (!_bankArray) {
        _bankArray = [NSMutableArray array];
    }
    return _bankArray;
}

-(NSMutableArray *)invoiceArray{
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
