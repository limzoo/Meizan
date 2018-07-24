//
//  WXLoginViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/23.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "WXLoginViewController.h"
#import "WXLoginView.h"
#import "WXLoginBindViewController.h"
@interface WXLoginViewController ()
@property (nonatomic, strong) NSString *access_token;
@property (nonatomic, strong) NSString *openid;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *photoUrl;
@property (nonatomic, strong) NSString *unionId;
@end

@implementation WXLoginViewController
- (instancetype)initWithAccess_token:(NSString *)access_token openid:(NSString *)openid unionId:(NSString *)unionId{
    self = [super init];
    if (self) {
        self.access_token = access_token;
        self.openid = openid;
        self.unionId = unionId;
        WXLoginView *view = [[WXLoginView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)loadUserInfo{
    [MZAFNetwork GET:@"https://api.weixin.qq.com/sns/userinfo" params:@{@"access_token":self.access_token,@"openid":self.openid} success:^(NSURLSessionDataTask *task, id responseObject) {
        [((WXLoginView *)self.view).iconIMGV sd_setImageWithURL:[NSURL URLWithString:[responseObject objectForKey:@"headimgurl"]]];
        ((WXLoginView *)self.view).nameLabel.text = [NSString stringWithFormat:@"亲爱的微信用户：%@",[responseObject objectForKey:@"nickname"]];
        self.nickName = [responseObject objectForKey:@"nickname"];
        self.photoUrl = [responseObject objectForKey:@"headimgurl"];
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    self.title = @"联合登录";
      [self loadUserInfo];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)moveToBindPage{
    WXLoginBindViewController *vc = [[WXLoginBindViewController alloc] initWithWxUnionId:self.unionId wxOpenId:self.openid nickName:self.nickName photoUrl:self.photoUrl];
    [self.navigationController pushViewController:vc animated:YES];
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
