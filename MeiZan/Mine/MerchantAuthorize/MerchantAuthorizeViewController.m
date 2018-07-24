//
//  MerchantAuthorizeViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MerchantAuthorizeViewController.h"
#import "MerchantAuthorizeView.h"
@interface MerchantAuthorizeViewController ()
@property (nonatomic, strong) NSMutableArray *imgPathArray;
@property (nonatomic, strong) NSString *photoPath1;
@property (nonatomic, strong) NSString *idCardFront;
@property (nonatomic, strong) NSString *idCardNegative;
@end

@implementation MerchantAuthorizeViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        [self queryAuthorize];
        MerchantAuthorizeView *view = [[MerchantAuthorizeView alloc] initWithFrame:self.view.frame];
        self.view = view;
        self.title = @"店铺认证";
        }
    return self;
}
- (void)queryAuthorize{
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    [MZAFNetwork POST:HOME_URL(@"/merchantInfo/queryMerchantInfo") params:@{@"id":[NSString stringWithFormat:@"%ld", config.userInfo.userId]} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            NSInteger authenticationStatus = ((NSNumber *)[responseObject objectForKey:@"authenticationStatus"]).integerValue;
            NSDictionary *merchantInfo = [responseObject objectForKey:@"merchantInfo"];
            NSString *tempStr;
            switch (((NSString *)[[responseObject objectForKey:@"merchantInfo"] objectForKey:@"authenticationStatus"]).intValue) {
                case 0:
                    tempStr = @"未审核";
                    break;
                case 1:
                    tempStr = @"已审核";
                    break;
                default:
                    break;
            }
            NSArray *tempArray = @[[responseObject objectForKey:@"realName"],[responseObject objectForKey:@"idCardNo"],tempStr,[merchantInfo objectForKey:@"merchantName"],[merchantInfo objectForKey:@"merchantAddress"],[merchantInfo objectForKey:@"merchantNo"]];
            ((MerchantAuthorizeView *)self.view).const_dataArray = tempArray;
          
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)merchantAuthorize{
    MerchantAuthorizeView *view = (MerchantAuthorizeView *)self.view;
    NSDictionary *param = @{@"merchantName":view.inputMessageArray[0],
                            @"merchantAddress":view.inputMessageArray[1],
                            @"businessLicenceNo":view.inputMessageArray[2],
                            @"userName":view.inputMessageArray[3],
                            @"idCardNo":view.inputMessageArray[4],
                            @"businessLicence":self.photoPath1,
                            @"idCardFront":self.idCardFront,
                            @"idCardNegative":self.idCardNegative
                            };
    [MZAFNetwork POST:HOME_URL(@"/merchantAuthentication/insertQualificationsImg") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            ;
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)uploadImg:(UIImage *)image tag:(NSInteger)tag{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    // 在parameters里存放照片以外的对象
    NSData *userConfigData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"];
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:userConfigData];
    NSString *url  = HOME_URL(@"/merchantAuthentication/uploadImg");
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?appId=%@&userId=%ld",[UIDevice currentDevice].identifierForVendor.UUIDString, config.userInfo.userId]];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    NSString *paramStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [manager POST:url parameters:@{@"imgFile":paramStr} progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            switch (tag) {
                case 1:
                    self.photoPath1 = [responseObject objectForKey:@"imgUrl"];
                    ((MerchantAuthorizeView *)self.view).image_1 = image;
                    break;
                case 2:
                    self.idCardFront = [responseObject objectForKey:@"imgUrl"];
                     ((MerchantAuthorizeView *)self.view).image_2 = image;
                    break;
                case 3:
                    self.idCardNegative = [responseObject objectForKey:@"imgUrl"];
                     ((MerchantAuthorizeView *)self.view).image_3 = image;
                    break;
                default:
                    break;
            }
            [((MerchantAuthorizeView *)self.view).mainTableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
    
//    [manager POST:HOME_URL(url) parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//            NSData *imageData = UIImageJPEGRepresentation(image, 1);
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"yyyyMMddHHmmss"];
//            NSString *dateString = [formatter stringFromDate:[NSDate date]];
//            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg",dateString];
//            /*
//             *该方法的参数
//             1. appendPartWithFileData：要上传的照片[二进制流]
//             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
//             3. fileName：要保存在服务器上的文件名
//             4. mimeType：上传的文件的类型
//             */
//
//            [formData appendPartWithFileData:[dateString dataUsingEncoding:NSUTF8StringEncoding] name:@"imgFile" fileName:fileName mimeType:@"image/png"]; //
//
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//        NSLog(@"---上传进度--- %@",uploadProgress);
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        ((MerchantAuthorizeView *)self.view).imagesArray[tag] = image;
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//        NSLog(@"xxx上传失败xxx %@", error);
//
//    }];
}
- (void)viewWillAppear:(BOOL)animated{
   [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self queryAuthorize];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)imgPathArray{
    if (!_imgPathArray) {
        _imgPathArray = [NSMutableArray arrayWithCapacity:3];
    }
    return _imgPathArray;
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
