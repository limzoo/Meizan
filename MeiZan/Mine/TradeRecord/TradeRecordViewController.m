//
//  TradeRecordViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/8.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "TradeRecordViewController.h"
#import "TradeRecordView.h"
#import "TradeRecordModel.h"
#import "KmWebReportFileVC.h"
#import "WKWebViewController.h"
@interface TradeRecordViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation TradeRecordViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        TradeRecordView *view = [[TradeRecordView alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.title = @"交易流水";
    UIButton *editButton = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:0 fontSize:16 title:@"报表"];
    editButton.frame = CGRectMake(0, 0, 80, 44);
    editButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [editButton addTarget:self action:@selector(downLoadReport) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *editBarButton = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = editBarButton;
}
- (void)downLoadReport{
    NSDate *date = [NSDate date]; // 获得时间对象
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    NSDate *dateNow = [date dateByAddingTimeInterval:time];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;//这句我也不明白具体时用来做什么。。。
    comps = [calendar components:unitFlags fromDate:dateNow];
    
    NSString *day=[comps day] < 10 ? [NSString stringWithFormat:@"0%ld",(long)[comps day]] : [NSString stringWithFormat:@"%ld",[comps day]];//获取日期对应的长整形字符
    NSString *year= [NSString stringWithFormat:@"%ld",(long)[comps year]];//获取日期对应的长整形字符//获取年对应的长整形字符
    
    NSString *month = [comps month] < 10 ? [NSString stringWithFormat:@"0%ld",(long)[comps month]] : [NSString stringWithFormat:@"%ld",[comps month]];//获取日期对应的长整形字符//获取月对应的长整形字符
    
    NSString *endTime = [NSString stringWithFormat:@"%@-%@-%@",year, month, day];
    
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData: [[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    NSString *urlStr = HOME_URL(@"/acTransactionFlow/exportExcel?accountType=3&transferType=4,6,7,8,9,10&startTime=2018-01-31");
    urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"&endTime=%@&appId=%@&userId=%ld",endTime,[UIDevice currentDevice].identifierForVendor.UUIDString, config.userInfo.userId]];
    NSURL* url = [NSURL URLWithString:urlStr];

    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        if (data) {
            
            NSString *document =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
            
            NSString *path = [document stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld", config.userInfo.userId]];
            
            NSFileManager *fileManager = [NSFileManager defaultManager];
            
            BOOL isDir = FALSE;
            
            BOOL isDirExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
            
            if(!(isDirExist && isDir))
            {
                BOOL bCreateDir = [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
                
                if(!bCreateDir){
                    
                    NSLog(@"创建文件夹失败！");
                }else {
                    NSLog(@"创建文件夹成功，文件路径%@",path);
                    
                }
            }
            
            // 如果该名称的文件还未拥有，就保存数据data
            
            NSString *dataPath = [path stringByAppendingString:[NSString stringWithFormat:@"/%@.xls",@"userReport"]];
            
            NSLog(@"%@",dataPath);
            
            
            bool result = [data writeToFile:dataPath atomically:YES];
            
            
            WKWebViewController *vc = [[WKWebViewController alloc] initWithXlsFileName:@"userReport"];
            [self.navigationController pushViewController:vc animated:YES];

        }else {
            [Tool showMessage:@"下载失败" duration:3];
        }

    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadPageDataWithPage:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPageDataWithPage:(NSUInteger)page{
    NSDictionary *param = @{@"accountType":@"3",
                            @"transferType":@"4,6,7,8,9,10",
                            @"page":[NSNumber numberWithUnsignedInteger:page],
                            @"limit":@"30"
                            };
    [MZAFNetwork POST:HOME_URL(@"/acTransactionFlow/queryAcTransactionFlow") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            for (NSDictionary *dic in [responseObject objectForKey:@"acTransactionFlowList"]) {
                TradeRecordModel *model = [[TradeRecordModel alloc] init];
                model = [TradeRecordModel yy_modelWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            ((TradeRecordView *)self.view).dataModelArray = self.dataArray;
            if (self.dataArray.count == 0) {
                [Tool showNoDataPicOnView:((TradeRecordView *)self.view).mainTableView withImage:[UIImage imageNamed:@"订单空"] title:@"暂无记录" size:CGSizeMake(138, 140) topDistance:150];
            }else{
                [Tool hideNoDataPicOnView:((TradeRecordView *)self.view).mainTableView];
            }
            [((TradeRecordView *)self.view).mainTableView reloadData];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
