//
//  AllCommentViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/22.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "AllCommentViewController.h"
#import "MerchandiseUserComment.h"
#import "AllComment.h"
@interface AllCommentViewController ()
@property (nonatomic, strong) NSString *type;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *goodsId;
@property (nonatomic, strong) NSMutableArray *commentArray;
@end

@implementation AllCommentViewController
- (instancetype)initWithGoodsId:(NSString *)goodsId;{
    self= [super init];
    if (self) {
        self.page = 1;
        self.goodsId = goodsId;
        AllComment *view = [[AllComment alloc] initWithFrame:self.view.frame];
        self.view = view;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadPageData];
    [self loadPageDataWithType:@"0" page:1];
    self.title = @"评价";
}
- (void)loadPageData{
    [MZAFNetwork POST:HOME_URL(@"/shopGoodsAppraises/queryAppraisesCount") params:@{@"goodsId":self.goodsId} success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            ((AllComment *)self.view).rateLabel.text = [NSString stringWithFormat:@"好评率%.2f",((NSNumber *)[responseObject objectForKey:@"rate"]).floatValue];
            [((AllComment *)self.view).allButton setTitle:[NSString stringWithFormat:@"全部(%ld)",((NSNumber *)[responseObject objectForKey:@"count"]).integerValue] forState:UIControlStateNormal];
            [((AllComment *)self.view).haveButton setTitle:[NSString stringWithFormat:@"有图(%ld)",((NSNumber *)[responseObject objectForKey:@"imgCount"]).integerValue] forState:UIControlStateNormal];
            [((AllComment *)self.view).haveButton setTitle:[NSString stringWithFormat:@"无图(%ld)",((NSNumber *)[responseObject objectForKey:@"count"]).integerValue - ((NSNumber *)[responseObject objectForKey:@"imgCount"]).integerValue]  forState:UIControlStateNormal];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
- (void)loadPageDataWithType:(NSString *)type page:(NSInteger)page{
    NSString *paramType;
    switch (type.integerValue) {
        case 0:
            paramType = @"";
            break;
        case 1:
            paramType = @"1";
            break;
        case 2:
            paramType = @"0";
            break;
        default:
            break;
    }
    self.page = page;
    NSDictionary *param = @{@"goodsId":self.goodsId,
                            @"appraisesAnnex":paramType,
                            @"page":[NSString stringWithFormat:@"%ld",page],
                            };
    [MZAFNetwork POST:HOME_URL(@"/shopGoodsAppraises/queryAppraisesList") params:param success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([[responseObject objectForKey:@"return_code"] isEqualToString:@"0000"]) {
            if (self.page == 1) {
                [self.commentArray removeAllObjects];
            }
            for (NSDictionary *dic in [responseObject objectForKey:@"appraisesList"]) {
                MerchandiseUserComment *model = [MerchandiseUserComment yy_modelWithDictionary:dic];
                [self.commentArray addObject:model];
            }
            ((AllComment *)self.view).dataArray = self.commentArray;
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

-(NSMutableArray *)commentArray{
    if (!_commentArray) {
        _commentArray = [NSMutableArray array];
    }
    return _commentArray;
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
