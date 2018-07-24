//
//  MyOrderView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/11.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyOrderView.h"
#import "LYSlideSelectBar.h"
#import "MyOrderModel.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderViewController.h"
#import "UploadVoucherViewController.h"
#import "UserCommentViewController.h"
#import "SelectPayStyleViewController.h"
#import "MyOrderDetailViewController.h"
@interface MyOrderView()<LYSlideSelectBarDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) LYSlideSelectBar *slideBar;
@property (nonatomic, strong) UIView *noDataView;
@end
@implementation MyOrderView

- (void)createSubview{
    
    self.slideBar = [[LYSlideSelectBar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 48) itemNum:6 slideViewBounds:CGSizeMake(0, 0)];
    [self.slideBar setSlideViewTinColor:[UIColor whiteColor]];
    [self addSubview:self.slideBar];
    self.slideBar.titles = @[@"全部",@"待付款",@"待审核",@"待发货",@"待评价",@"待收货"];
    self.slideBar.titlesFont = @[[UIFont fontWithName:@"PingFangSC-Regular" size:14],[UIFont fontWithName:@"PingFangSC-Regular" size:14],[UIFont fontWithName:@"PingFangSC-Regular" size:14],[UIFont fontWithName:@"PingFangSC-Regular" size:14],[UIFont fontWithName:@"PingFangSC-Regular" size:14],[UIFont fontWithName:@"PingFangSC-Regular" size:14]];
    [self.slideBar setItemTinColor:STYLECOLOR defaultColor:TITLECOLOR];
    self.slideBar.delegate = self;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = INSETCOLOR;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.slideBar.mas_bottom);
    }];
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    [self.mainTableView registerClass:[MyOrderTableViewCell class] forCellReuseIdentifier:@"MyOrderTableViewCell"];
    [self addSubview:self.mainTableView];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.mas_equalTo(self);
        make.top.mas_equalTo(lineView.mas_bottom);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderModel *model = self.dataArray[indexPath.row];
    return 110 + model.goodsList.count * 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyOrderTableViewCell"];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.rightButton.tag = indexPath.row + 100;
    [cell.rightButton addTarget:self action:@selector(rightButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
    cell.middleButton.tag = indexPath.row + 101;
    [cell.middleButton addTarget:self action:@selector(middleButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
    cell.leftButton.tag = indexPath.row + 102;
    [cell.leftButton addTarget:self action:@selector(leftButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderModel *model = self.dataArray[indexPath.row];
    MyOrderDetailViewController *vc = [[MyOrderDetailViewController alloc] initWithModel:model];
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}

- (void)slideSelectBar:(LYSlideSelectBar *)slideSelectBar didSelectAnotherItemAtIndex:(NSUInteger)index{
    self.currentIndex = index;
    //订单状态(0-待支付1-已支付2-已发货3-已确认4-已评价5-已取消6-待审核7-审核失败)
    [((MyOrderViewController *)self.myViewController) loadPageDataWithIndex:index page:1];
}

- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.mainTableView reloadData];
    if (dataArray.count > 0) {
    [self.mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        [Tool hideNoDataPicOnView:self.mainTableView];
    }else{
        [Tool showNoDataPicOnView:self.mainTableView withImage:[UIImage imageNamed:@"订单空"] title:@"暂无订单" size:CGSizeMake(138, 138) topDistance:100];
    }
}

- (void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    [self.slideBar setCurrentSelectedIndex:currentIndex];
}

- (void)rightButtonAciton:(UIButton *)sender{
    MyOrderModel *model = self.dataArray[sender.tag - 100];
    switch (model.ORDER_STATUS.intValue) {
        case 0:{
            SelectPayStyleViewController *vc =[[SelectPayStyleViewController alloc] initWithOrderModel:model];
             [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 6:{
            NSLog(@"1");
            break;
        }
        case 1:{
            NSLog(@"1");
            break;
        }
        case 3:{
            UserCommentViewController *vc = [[UserCommentViewController alloc] initWithModel:model];
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:{
            [((MyOrderViewController *)self.myViewController) updateOrder:model status:3];
            break;
        }
        default:
            break;
    }
}
- (void)middleButtonAciton:(UIButton *)sender{
    MyOrderModel *model = self.dataArray[sender.tag - 101];
    switch (model.ORDER_STATUS.intValue) {
        case 0:{
            [((MyOrderViewController *)self.myViewController) updateOrder:model status:5];
            break;
        }
        case 6:{
            NSLog(@"1");
            break;
        }
        case 1:{
            NSLog(@"1");
            break;
        }
        case 3:{
            NSLog(@"1");
            break;
        }
        case 2:{
            NSLog(@"1");
            break;
        }
            
        default:
            break;
    }
}
- (void)leftButtonAciton:(UIButton *)sender{
    MyOrderModel *model = self.dataArray[sender.tag - 102];
    switch (model.ORDER_STATUS.intValue) {
        case 0:{
            UploadVoucherViewController *vc = [[UploadVoucherViewController alloc] initWithModel:model];
            [self.myViewController.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
