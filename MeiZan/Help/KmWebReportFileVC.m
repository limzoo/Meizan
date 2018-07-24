//
//  KmWebReportFileVC.m
//  rhjt
//
//  Created by sfs on 2017/5/16.
//  Copyright © 2017年 sfs. All rights reserved.
//

#import "KmWebReportFileVC.h"

@interface KmWebReportFileVC ()<UIWebViewDelegate>

@property (nonatomic, strong)UIView *blackView ;

@property (nonatomic, strong)UIButton *black ;

@property (nonatomic, strong)UIView *shareBackView ;

@property (nonatomic, strong)UIWebView *webView ;

@end

@implementation KmWebReportFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@报表",_fileName];
    
    // 保存按钮
//    UIButton *saveBut = [UIButton buttonWithType:UIButtonTypeCustom];
    
//    saveBut.frame = CGRectMake(0, 0, 44, 44);
//
//    KMButTitleSet(saveBut, @"分享", 16, BackgroundColor);
    
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:saveBut];
    
//    [saveBut addTarget:self action:@selector(shareFile) forControlEvents:UIControlEventTouchUpInside];
    
//    self.navigationItem.rightBarButtonItem = rightItem;
    
    //3.创建WebView
    _webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    
//    _webView.scalesPageToFit=YES;//点击伸缩效果的
    
    _webView.delegate = self;
    
    [self.view addSubview:_webView];
    
    if (_fileName) {

//        NSString *document =  DEF_DocumentsDir ;
        
//        NSString *path = [document stringByAppendingPathComponent:_storeId];
        
//        NSString *dataPath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@.xls",_fileName]];

//        NSURL *myDocument=[NSURL fileURLWithPath:dataPath];
        
//        NSURLRequest *request=[NSURLRequest requestWithURL:myDocument];
//
//        [_webView loadRequest:request];
  
    }else {
        [Tool showMessage:@"文件好像不见了（委屈~）..." duration:3];
    }
    
    
}

// 完成
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [Tool showMessage:@"加载成功" duration:1];
}

// 出错
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {

    if (error) {
        [Tool showMessage:@"加载出错，请重试" duration:1];
    }
}

//// 分享
//- (void)shareFile {
//
//    if (!_blackView) {
//        // 总试图
//        _blackView = [[UIView alloc]init];
//
////        _blackView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
////
////        _blackView.backgroundColor = CLEARCOLOR;
//
//        // 添加到window上
//        [ [ [ UIApplication  sharedApplication ]  keyWindow ] addSubview : _blackView ];
//
//        // 黑色画布
//        _black = [[UIButton alloc]init];
//
//        _black.backgroundColor = [UIColor blackColor];
//
////        _black.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
//
//        [_black addTarget:self action:@selector(cancerShare) forControlEvents:UIControlEventTouchUpInside];
//
//        _black.alpha = 0.4;
//
//        [_blackView addSubview:_black];
//
//        // 详情
////        _shareBackView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_H, DEF_FRAME_WIDTH, CustomWindowHeight(213))];
//
//        _shareBackView.alpha = 0.9;
//
////        _shareBackView.backgroundColor = WHITECOLOR;
//
//        [_blackView addSubview:_shareBackView];
//
//        // 取消按钮
//        UIButton *cancerBut = [UIButton buttonWithType:UIButtonTypeCustom];
//        [cancerBut addTarget:self action:@selector(cancerShare) forControlEvents:UIControlEventTouchUpInside];
//
//        cancerBut.alpha = 0.2;
//
//        [_blackView addSubview:cancerBut];
////
////        [cancerBut mas_makeConstraints:^(MASConstraintMaker *make) {
////            make.bottom.equalTo(_shareBackView.mas_bottom);
////            make.height.mas_equalTo(Custom_Width(49));
////            make.left.equalTo(_shareBackView);
////            make.right.equalTo(_shareBackView);
////        }];
////
//        KmColorToColor(cancerBut, COLOR_RGB16(0xffc045), COLOR_RGB16(0xff6300));
//
//        // 文字不透明
//        UILabel *butLabel = [UILabel new];
//
////        KMLabelTextSet(butLabel, @"取消", 16, BackgroundColor);
////
////        butLabel.backgroundColor = CLEARCOLOR;
//
//        butLabel.textAlignment = NSTextAlignmentCenter;
//
//        [_blackView addSubview:butLabel];
//
//        [butLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(_shareBackView.mas_bottom);
//            make.height.mas_equalTo(Custom_Width(49));
//            make.left.equalTo(_shareBackView);
//            make.right.equalTo(_shareBackView);
//        }];

        // 文字
//        UILabel *label = [UILabel new];
//
//        label.textAlignment = NSTextAlignmentCenter;
//
////        KMLabelTextSet(label, @"分享给小伙伴", 14, L_TextBackgroundColor);
//
//        [_shareBackView addSubview:label];
//
//        [label mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_shareBackView).offset(CustomWindowHeight(20));
//            make.left.equalTo(_shareBackView);
//            make.right.equalTo(_shareBackView);
//            make.height.mas_equalTo(CustomWindowHeight(14));
//        }];
        
        // 微信分享
//        UIButton *leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
//
//        [leftBut addTarget:self action:@selector(sharetoweixin) forControlEvents:UIControlEventTouchUpInside];
//
//        [_shareBackView addSubview:leftBut];
//
//        [leftBut mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_shareBackView).offset(CustomWindowHeight(86));
//            make.top.equalTo(label.mas_bottom).offset(CustomWindowHeight(20));
//            make.width.mas_equalTo(Custom_Width(60));
//            make.height.mas_equalTo(CustomWindowHeight(82));
//        }];
        
//        // 腾讯分享
//        UIButton *rightBut = [UIButton buttonWithType:UIButtonTypeCustom];
//
//        [rightBut addTarget:self action:@selector(shareTenXun) forControlEvents:UIControlEventTouchUpInside];
//
//        [_shareBackView addSubview:rightBut];
//
//
//        [rightBut mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(_shareBackView).offset(-CustomWindowHeight(86));
//            make.top.equalTo(label.mas_bottom).offset(CustomWindowHeight(20));
//            make.width.mas_equalTo(Custom_Width(60));
//            make.height.mas_equalTo(CustomWindowHeight(82));
//
//        }];
//
//        [self shareButCreateWithBut:leftBut andImageName:@"icon_fenxiang_weixin" andText:@"微信"];
//
//        [self shareButCreateWithBut:rightBut andImageName:@"icon_fenxiang_qq" andText:@"QQ"];
//
//
//        _blackView.alpha = 0;
//    }
    
//    [UIView animateWithDuration:0.3 animations:^{
//
//        _blackView.alpha=1;
//
//        _shareBackView.frame = CGRectMake(0, SCREEN_H-CustomWindowHeight(213), DEF_FRAME_WIDTH, CustomWindowHeight(213));
//
//    }];
//
//}

///// 分享按钮的创建
//- (void)shareButCreateWithBut:(UIButton *)button andImageName:(NSString *)name andText:(NSString *)text {
//
//    UILabel *label = [UILabel new];
//
//    KMLabelTextSet(label, text, 12, R_TextBackgroundColor);
//
//    label.textAlignment = NSTextAlignmentCenter;
//
//    [button addSubview:label];
//
//    UIImageView *image = [UIImageView new];
//
//    image.image = [UIImage imageNamed:name];
//
//    [button addSubview:image];
//
//    [image mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(button);
//        make.left.equalTo(button);
//        make.right.equalTo(button);
//        make.height.equalTo(image.mas_width);
//    }];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(button);
//        make.left.equalTo(button);
//        make.right.equalTo(button);
//        make.height.mas_equalTo(12);
//    }];
//
//}
//
//// 微信分享
//- (void)sharetoweixin {
//
//    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
//
//    [UIView animateWithDuration:0.3 animations:^{
//
//        _blackView.alpha= 0;
//
//        _shareBackView.frame = CGRectMake(0, SCREEN_H, DEF_FRAME_WIDTH, CustomWindowHeight(213));
//
//    }];
//}
//
//// 腾讯分享
//- (void)shareTenXun {
//
//    [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];
//
//    [UIView animateWithDuration:0.3 animations:^{
//
//        _blackView.alpha= 0 ;
//
//        _shareBackView.frame = CGRectMake(0, SCREEN_H, DEF_FRAME_WIDTH, CustomWindowHeight(213));
//
//    }];
//}

//// 友盟 分享地址
//- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
//{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//
//    //创建网页内容对象
//    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"融和宝财务报表" descr:@"融和宝财务报表，时时刻刻关注您的流水......" thumImage:[UIImage imageNamed:@"um_logo"]];
//    //设置网页地址
//
//    // 正式网
//    shareObject.webpageUrl = [NSString stringWithFormat:@"%@://wx.payrong.com/page/report?a=a&user_id=%@&from=singlemessage&isappinstalled=0",HTTP,_storeId];
//
//    //测试网
////    shareObject.webpageUrl = [NSString stringWithFormat:@"http://wx.payrong.com/page/report?a=a&user_id=%@&from=singlemessage&isappinstalled=0",_storeId];
//
//    NSLog(@"分享地址%@",shareObject.webpageUrl);
//
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            [Tool HUDAutoHiddenWithText:@"分享失败"];
//        }else{
//            [Tool HUDAutoHiddenWithText:@"分享成功"];
//        }
//    }];
//}
//
//// 取消分享
//- (void)cancerShare {
//
//    [UIView animateWithDuration:0.3 animations:^{
//
//        _blackView.alpha= 0;
//
//        _shareBackView.frame = CGRectMake(0, SCREEN_H, DEF_FRAME_WIDTH, CustomWindowHeight(213));
//
//    }];
//}

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:YES];
//
//    _blackView = nil;
//
//    [_blackView removeFromSuperview];
//}

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
