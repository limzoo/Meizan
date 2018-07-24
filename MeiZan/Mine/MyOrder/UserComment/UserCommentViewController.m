//
//  UserCommentViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "UserCommentViewController.h"
#import "UserCommentView.h"
@interface UserCommentViewController ()
@property (nonatomic, strong) MyOrderModel *model;
@end

@implementation UserCommentViewController
- (instancetype)initWithModel:(MyOrderModel *)model{
    self = [super init];
    if (self) {
        self.model = model;
        UserCommentView *view = [[UserCommentView alloc] initWithFrame:self.view.frame];
        view.model = model;
        self.view = view;
    }
    return self;
}
- (void)uploadImg:(UIImage *)image withRow:(NSInteger)row{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    // 在parameters里存放照片以外的对象
    NSData *userConfigData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"];
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:userConfigData];
    NSString *url  = HOME_URL(@"/shopGoodsAppraises/uploadImgFile");
    url = [url stringByAppendingString:[NSString stringWithFormat:@"?appId=%@&userId=%ld",[UIDevice currentDevice].identifierForVendor.UUIDString, config.userInfo.userId]];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    NSString *paramStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [manager POST:url parameters:@{@"imgFile":paramStr,@"id":self.model.orderId} progress:^(NSProgress * _Nonnull uploadProgress) {
        ;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            [((UserCommentView *)self.view) insertPhotoUrlInCommentArray:[responseObject objectForKey:@"imgUrl"] image:image];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        ;
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"提交评价";
}
- (void)confirmComment:(NSString *)string{
    [MZAFNetwork POST:HOME_URL(@"/shopGoodsAppraises/insertAppraises") params:@{@"appraisesStr":string} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
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
