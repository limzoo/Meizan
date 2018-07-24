//
//  WKWebViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
@interface WKWebViewController ()
@property (nonatomic, strong) NSString *urlStr;
@property (nonatomic, strong) WKWebView *myWebView;
@property (nonatomic, strong) NSString *fileName;
@end

@implementation WKWebViewController
- (instancetype)initWithUrl:(NSString *)urlStr{
    self = [super init];
    if (self) {
        self.urlStr = urlStr;
        [self createSubview];
    }
    return self;
}

- (instancetype)initWithXlsFileName:(NSString *)fileName{
    self = [super init];
    if (self) {
        self.fileName = fileName;
        [self createSubview];
    }
    return self;
}

- (void)createSubview{
    self.myWebView = [[WKWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.myWebView];
    if (self.urlStr != nil) {
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
    }else{
        [self setTitle:@"报表"];
        NSString *document =   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
        UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
        NSString *path = [document stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld",config.userInfo.userId]];
        
        NSString *dataPath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@.xls",self.fileName]];
        
        NSURL *myDocument=[NSURL fileURLWithPath:dataPath];
        
        NSURLRequest *request=[NSURLRequest requestWithURL:myDocument];
        
        [self.myWebView loadRequest:request];
    }
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
