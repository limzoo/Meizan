//
//  UploadVoucherViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/18.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UploadVoucherViewController.h"
#import "UploadVoucherView.h"
@interface UploadVoucherViewController ()
@property (nonatomic, strong) MyOrderModel *model;
@property (nonatomic, strong) NSString *imgPath;
@end

@implementation UploadVoucherViewController
- (instancetype)initWithModel:(MyOrderModel *)model{
    self = [super init];
    if (self) {
        UploadVoucherView *view = [[UploadVoucherView alloc] initWithFrame:self.view.frame];
        self.model = model;
        view.model = model;
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadPageData];
    self.title = @"上传凭证";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)uploadVoucherImg:(UIImage *)img{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    // 在parameters里存放照片以外的对象
    NSData *userConfigData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"];
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:userConfigData];
    NSString *url  = HOME_URL(@"/orderPaymentInfo/uploadImg");
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?appId=%@&userId=%ld",[UIDevice currentDevice].identifierForVendor.UUIDString, config.userInfo.userId]];
    NSData *data = UIImageJPEGRepresentation(img, 1);
    NSString *paramStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [manager POST:url parameters:@{@"imgFile":paramStr,@"id":self.model.orderId} progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            ((UploadVoucherView *)self.view).photo.image = img;
            self.imgPath = [responseObject objectForKey:@"imgUrl"];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
}

- (void)loadPageData{
    [MZAFNetwork POST:HOME_URL(@"/orderInfo/queryCollectDetails") params:@{@"orderId":self.model.orderId} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
            ((UploadVoucherView *)self.view).name.text = [responseObject objectForKey:@"collectName"];
             ((UploadVoucherView *)self.view).bankCard.text = [responseObject objectForKey:@"collectBankNo"];
             ((UploadVoucherView *)self.view).bankName.text = [[responseObject objectForKey:@"collectBankName"] stringByAppendingString:[responseObject objectForKey:@"collectBankBranchName"]];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)uploadVoucher{
    if (self.imgPath == nil ||self.imgPath.length == 0) {
        [Tool showMessage:@"请上传汇款凭证" duration:3];
        return;
    }
    [MZAFNetwork POST:HOME_URL(@"/orderInfo/payVoucher") params:@{@"orderId":self.model.orderId,@"paymentCert":self.imgPath} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
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
