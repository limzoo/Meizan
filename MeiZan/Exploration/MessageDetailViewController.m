//
//  MessageDetailViewController.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/21.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MessageDetailViewController.h"
#import "MessageDetailView.h"
#import "UserMessageModel.h"
@interface MessageDetailViewController ()
@property (nonatomic, strong) UserMessageModel *model;
@end

@implementation MessageDetailViewController
- (instancetype)initWithModel:(UserMessageModel *)model{
    self = [super init];
    if (self) {
        MessageDetailView *view = [[MessageDetailView alloc] initWithFrame:self.view.frame];
        self.model = model;
        self.view = view;
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"消息";
    ((MessageDetailView *)self.view).model = _model;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setMsgRead];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setMsgRead{
    [MZAFNetwork POST:HOME_URL(@"/messageInfo/updateMessageIsRead") params:@{@"messageId":[NSString stringWithFormat:@"%ld",self.model.ID]} success:^(NSURLSessionDataTask *task, id responseObject) {
        ;
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
