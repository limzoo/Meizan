//
//  MerchandiseView.m
//  JingXuan
//
//  Created by sfs on 2017/12/11.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MerchandiseView.h"
#import "MakeOrderViewController.h"
#import "MerchandiseSelectType.h"
#import "EmptyCommentTableViewCell.h"
#import "AllCommentViewController.h"
#import "MerchandiseViewController.h"
@interface MerchandiseView()<UITableViewDelegate, UITableViewDataSource>

@end
@implementation MerchandiseView
- (void)moveToCommentPage:(UIButton *)button{
    AllCommentViewController *vc = [[AllCommentViewController alloc] initWithGoodsId:[NSString stringWithFormat:@"%ld",self.model.merchandiseId.integerValue]];
    [self.myViewController.navigationController pushViewController:vc animated:YES];
}
- (void)makeOrder:(UIButton *)sender{
    ((MerchandiseSelectType*)self.selectVC.view).type = 1;
    self.selectVC.baseVC = self.myViewController;
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.masksView];
    [self.masksView setHidden:NO];
    [self bringSubviewToFront:self.selectTypeView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self.selectTypeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(356);
    }];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
            
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return self.bounds.size.width / 375 * 280 + 96;
            break;
        case 1:
            //            return 126 + [Tool calculateCellHeightWithArray:@[@"7天无忧退货",@"48小时快速退款",@"我也不知道些什么了就是凑个数"] width:290];
            return 45;
            break;
        case 2:
            return 262;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            MerchandiseHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchandiseHeaderTableViewCell" forIndexPath:indexPath];
            [cell.lookButton addTarget:self action:@selector(moveToCommentPage:) forControlEvents:UIControlEventTouchUpInside];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.model;
            cell.goodsImageArray = self.goodsImagesArray;
            return cell;
            break;
        }
        case 1:{
            SearchListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchListTableViewCell" forIndexPath:indexPath];
            NSArray *titleArray = @[@"7天无忧退货",@"48小时快速退款",@"我也不知道些什么了就是凑个数"];
            cell.titlesArray = titleArray;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            __weak typeof(self) weakSelf = self;
            cell.showSelectView = ^{
                [[UIApplication sharedApplication].keyWindow bringSubviewToFront:weakSelf.masksView];
                [weakSelf.masksView setHidden:NO];
                [weakSelf bringSubviewToFront:weakSelf.selectTypeView];
                [weakSelf setNeedsUpdateConstraints];
                [weakSelf updateConstraintsIfNeeded];
                [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
                    [weakSelf.selectTypeView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(356);
                    }];
                    [weakSelf layoutIfNeeded];
                } completion:^(BOOL finished) {
                    
                }];
            };
            return cell;
            break;
        }
        case 2:{
            if (self.comment == nil || self.comment.ID == 0) {
                EmptyCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EmptyCommentTableViewCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                UserReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserReplyTableViewCell" ];
                if (!cell) {
                    cell = [[UserReplyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UserReplyTableViewCell"];
                    UIButton *moreButton = [UIButton initCustomTypeButtonWithTextColor:STYLECOLOR backGroudColor:[UIColor whiteColor] cornerRadius:2 fontSize:14 title:@"查看更多"];
                    moreButton.layer.borderWidth = 0.5;
                    moreButton.layer.borderColor = STYLECOLOR.CGColor;
                    [moreButton addTarget:self action:@selector(moveToCommentPage:) forControlEvents:UIControlEventTouchUpInside];
                    [cell.contentView addSubview:moreButton];
                    
                    [moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.mas_equalTo(cell);
                        make.height.mas_equalTo(CUSTOM_HEIGHT(22));
                        make.width.mas_equalTo(CUSTOM_WIDTH(72));
                        make.bottom.mas_equalTo(cell).offset(-CUSTOM_HEIGHT(16));
                    }];
                }
                cell.model = self.comment;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
            break;
        }
        default:
            break;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 2:{
            UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44)];
            headView.backgroundColor = [UIColor whiteColor];
            UILabel *title = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:TEXTCOLOR text:[NSString stringWithFormat:@"用户评价(%ld)",self.model.count.integerValue]];
            [headView addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(headView);
                make.leading.mas_equalTo(headView).offset(CUSTOM_WIDTH(14));
            }];
            
            
            UIImageView *arrowIMGV = [[UIImageView alloc] init];
            arrowIMGV.image = [UIImage imageNamed:@"rightArrow"];
            [headView addSubview:arrowIMGV];
            [arrowIMGV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(8);
                make.height.mas_equalTo(13);
                make.trailing.mas_equalTo(headView).offset(-CUSTOM_WIDTH(14));
                make.centerY.mas_equalTo(headView);
            }];
            
            
//            UILabel *detail = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:COLOR_RGB16(0x999999) text:[NSString stringWithFormat:@" %ld人好评", self.model.]];
//            [headView addSubview:detail];
//            [detail mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerY.mas_equalTo(headView);
//                make.trailing.mas_equalTo(arrowIMGV.mas_leading).offset(-CUSTOM_WIDTH(14));
//            }];
            
            UIView *lineView = [[UIView alloc] init];
            lineView.backgroundColor = INSETCOLOR;
            [headView addSubview:lineView];
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.leading.bottom.trailing.mas_equalTo(headView);
                make.height.mas_equalTo(1);
            }];
            return headView;
            break;
        }
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 2:{
            if (self.comment == nil) {
                return 0;
            }else{
                return 44;
            }
            break;
        }
        default:
            break;
    }
    return 0;
}
- (void)configInitial{
    self.currentSegmentIndex = 0;
}
- (void)createSubview{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *shopCartView = [[UIView alloc] init];
    shopCartView.clipsToBounds = NO;
    shopCartView.backgroundColor = [UIColor whiteColor];
    [self addSubview:shopCartView];
    [shopCartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.mas_equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    
    UIButton *buy = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor]  backGroudColor:COLOR_RGB16(0xf67a00) cornerRadius:0 fontSize:16 title:@"立即购买"];
    [buy addTarget:self action:@selector(makeOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:buy];
    [buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.trailing.mas_equalTo(self);
        make.height.mas_equalTo(shopCartView);
        make.width.mas_equalTo(CUSTOM_WIDTH(110));
        make.leading.mas_equalTo(shopCartView.mas_trailing);
    }];
    
    UIButton *shopCart = [UIButton initCustomTypeButtonWithTextColor:[UIColor whiteColor]  backGroudColor:STYLECOLOR cornerRadius:0 fontSize:16 title:@"加入购物车"];
    [shopCart addTarget:self action:@selector(addToshopCart:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shopCart];
    [shopCart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(shopCartView);
        make.width.mas_equalTo(CUSTOM_WIDTH(110));
        make.trailing.mas_equalTo(buy.mas_leading);
    }];
    
    self.priceLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:16] color:STYLECOLOR text:@""];
    self.priceLabel.textAlignment = NSTextAlignmentRight;
    [shopCartView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(shopCartView);
        make.trailing.mas_equalTo(shopCart.mas_leading).offset(-CUSTOM_WIDTH(14));
    }];
    
    UIButton *shopCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shopCartButton addTarget:self action:@selector(moveToShopCartPage) forControlEvents:UIControlEventTouchUpInside];
    shopCartButton.backgroundColor = [UIColor whiteColor];
    [shopCartButton setImage:[UIImage imageNamed:@"购物车_unselected"] forState:UIControlStateNormal];
    shopCartButton.layer.cornerRadius = 22;
    shopCartButton.layer.borderWidth = 1;
    shopCartButton.layer.borderColor = COLOR_RGB16(0xe5e5e5).CGColor;
    shopCartButton.layer.masksToBounds = NO;
    shopCartButton.layer.shadowColor = COLOR_RGB16(0xdddddd).CGColor;
    shopCartButton.layer.shadowOffset = CGSizeMake(2, 2);
    shopCartButton.layer.shadowRadius = 4;
    shopCartButton.layer.shadowOpacity = 0.4;
    [self addSubview:shopCartButton];
    [shopCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(44);
        make.centerY.mas_equalTo(shopCartView).offset(-25);
        make.leading.mas_equalTo(self).offset(CUSTOM_WIDTH(14));
    }];
    
    self.shopCartNumLabel = [UILabel initWithSystemFontOfSize:12 color:[UIColor whiteColor] text:@""];
    self.shopCartNumLabel.textAlignment = NSTextAlignmentCenter;
    self.shopCartNumLabel.layer.masksToBounds = YES;
    self.shopCartNumLabel.layer.cornerRadius = 7.0f;
    self.shopCartNumLabel.backgroundColor = COLOR_RGB16(0xff4239);
    [self addSubview:self.shopCartNumLabel];
    [self.shopCartNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.trailing.mas_equalTo(shopCartButton);
        make.width.height.mas_equalTo(14);
    }];
    
    
    UIView *lineView_1 = [[UIView alloc] init];
    lineView_1.tag = 10;//懒得做属性
    lineView_1.backgroundColor = INSETCOLOR_F5;
    [self addSubview:lineView_1];
    [lineView_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(shopCartView.mas_top);
        make.height.mas_equalTo(1);
    }];
    
    
    [self addSubview:self.myWebView];
    self.myWebView.progressView.hidden = YES;
    [self.myWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
        make.leading.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(lineView_1.mas_top);
    }];
    
    self.mainTableView = [[UITableView alloc] init];
    self.mainTableView.backgroundColor = INSETCOLOR_F5;
    self.mainTableView.delegate =self;
    self.mainTableView.dataSource = self;
    self.mainTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self.mainTableView registerClass:[MerchandiseHeaderTableViewCell class] forCellReuseIdentifier:@"MerchandiseHeaderTableViewCell"];
    [self.mainTableView registerClass:[SearchListTableViewCell class] forCellReuseIdentifier:@"SearchListTableViewCell"];
//    [self.mainTableView registerClass:[UserReplyTableViewCell class] forCellReuseIdentifier:@"UserReplyTableViewCell"];
    [self.mainTableView registerClass:[EmptyCommentTableViewCell class] forCellReuseIdentifier:@"EmptyCommentTableViewCell"];
    [self addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo(self.myWebView.mas_top);
    }];
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        [self.mainTableView.mj_footer endRefreshing];
    }];//什么也没干,交给scrollView做
    [footer setTitle:@"上拉查看更多详情" forState:MJRefreshStateRefreshing];
    [footer setTitle:@"上拉查看更多详情" forState:MJRefreshStateIdle];
    [footer setTitle:@"上拉查看更多详情" forState:MJRefreshStatePulling];
    self.mainTableView.mj_footer = footer;
    self.mainTableView.mj_footer.backgroundColor = [UIColor whiteColor];
    //    self.mainTableView.mj_footer.mj_h = 40;
    
    
    self.masksView = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
//    [self.masksView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeMaskPage)]];
    self.masksView.hidden = YES;
    self.masksView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:self.masksView];
    [self.masksView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.mas_equalTo([UIApplication sharedApplication].keyWindow);
        make.bottom.mas_equalTo([UIApplication sharedApplication].keyWindow);
    }];
    
    self.selectVC = [[MerchandiseSelectTypeViewController alloc] initWithType:0];
    self.selectVC.dataArray = self.typeModelArray;
    self.selectTypeView = [[UIView alloc] init];
    self.selectTypeView.userInteractionEnabled = YES;
    self.selectTypeView.backgroundColor = [UIColor whiteColor];
    [self.masksView addSubview:self.selectTypeView];
    [self.selectTypeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(self.masksView);
        make.height.mas_equalTo(0);
    }];
    
    [self.selectTypeView addSubview:self.selectVC.view];
    [self.selectVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.bottom.trailing.mas_equalTo(self.selectTypeView);
    }];
    
    [self bringSubviewToFront:shopCartButton];
    [self bringSubviewToFront:self.shopCartNumLabel];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeMaskPage:) name:@"removeSelectPage" object:nil];
    //监听弹出键盘
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    //可以监听收回键盘
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self layoutIfNeeded];
}

- (void)keyboardWillShow:(NSNotification *)aNotification

{
    NSDictionary *userInfo = [aNotification userInfo];

    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];

    CGRect keyboardRect = [aValue CGRectValue];

    int height = keyboardRect.size.height;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.selectTypeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.masksView).offset(-height);
        }];
    });
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
      [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
- (void)keyboardWillHide:(NSNotification *)aNotification{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.selectTypeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.masksView);
        }];
    });
}
- (void)addToshopCart:(UIButton *)sender{
    ((MerchandiseSelectType*)self.selectVC.view).type = 0;
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self.masksView];
    [self.masksView setHidden:NO];
    [self bringSubviewToFront:self.selectTypeView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [self.selectTypeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(356);
    }];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView == self.mainTableView) {
        if ( self.mainTableView.contentSize.height + 40 < scrollView.contentOffset.y + self.mainTableView.bounds.size.height) {
            [((UISegmentedControl *)[self.myViewController valueForKey:@"segmentCtrl"]) setSelectedSegmentIndex:1];
            self.currentSegmentIndex = 1;
            [self showWebView];
        }
    }
    
    if (scrollView == self.myWebView.scrollView) {
        if ( scrollView.contentOffset.y < -40) {
            [((UISegmentedControl *)[self.myViewController valueForKey:@"segmentCtrl"]) setSelectedSegmentIndex:0];
            self.currentSegmentIndex = 0;
            [self hideWebView];
        }
    }
}

//隐藏tableView 显示webView
- (void)showWebView{
    NSString *url = HOME_URL(@"/shopGoodsInfo/viewShopGoodsContent");
    NSData *userConfigData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"];
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:userConfigData];
    if (config.userInfo.userId != 0) {
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?id=%ld&appId=%@&userId=%ld",self.model.merchandiseId.integerValue,[UIDevice currentDevice].identifierForVendor.UUIDString, config.userInfo.userId]];
    }else{
        url = [url stringByAppendingString:[NSString stringWithFormat:@"?id=%ld&appId=%@",self.model.merchandiseId.integerValue,[UIDevice currentDevice].identifierForVendor.UUIDString]];
    }
    
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [self.myWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.mas_equalTo(self);
        make.bottom.mas_equalTo([self viewWithTag:10].mas_top);
    }];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self layoutIfNeeded];
        [self.myWebView.scrollView setContentOffset:CGPointMake(0, 40) animated:NO];
    } completion:^(BOOL finished) {
        self.myWebView.progressView.hidden = NO;
    }];
    
}

- (void)hideWebView{
//    self.myWebView.progressView.hidden = YES;
//    [self.myWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(0);
//        make.leading.trailing.mas_equalTo(self);
//        make.bottom.mas_equalTo([self viewWithTag:10].mas_top);
//    }];
//
//    [self setNeedsUpdateConstraints];
//    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.myWebView.progressView.hidden = YES;
        [self.myWebView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
            make.leading.trailing.mas_equalTo(self);
            make.bottom.mas_equalTo([self viewWithTag:10].mas_top);
        }];
        [self layoutIfNeeded];
        [self.mainTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    } completion:^(BOOL finished) {
        ;
    }];
}
- (BaseWebView *)myWebView{
    if (!_myWebView) {
        _myWebView = [[BaseWebView alloc] init];
        _myWebView.scrollView.delegate = self;
        MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingBlock:^{
            [_myWebView.scrollView.mj_header endRefreshing];
        }];
        header.lastUpdatedTimeLabel.hidden = YES;
        [header setTitle:@"下拉返回" forState:MJRefreshStateRefreshing];
        [header setTitle:@"下拉返回" forState:MJRefreshStateIdle];
        [header setTitle:@"下拉返回" forState:MJRefreshStatePulling];
        _myWebView.scrollView.mj_header = header;
    }
    return _myWebView;
}
- (void)removeMaskPage:(NSNotification*)notification{
    NSDictionary *dataDic = notification.userInfo;
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
    NSNumber *selectNum = [dataDic objectForKey:@"number"];
    //用户类型(1.商户;2个人;3总代理商;4县代理商)
    switch (config.userInfo.userType.intValue) {
        case 1:{
            self.priceLabel.text = [NSString stringWithFormat:@"合计:¥%.2f",self.model.price.floatValue * selectNum.integerValue];
            break;
        }
        case 2:{
              self.priceLabel.text = [NSString stringWithFormat:@"合计:¥%.2f",self.model.price.floatValue * selectNum.integerValue];
            break;
        }
        case 3:{
            self.priceLabel.text = [NSString stringWithFormat:@"合计:¥%.2f",self.model.mainAgentPrice.floatValue * selectNum.integerValue];
            break;
        }
        case 4:{
             self.priceLabel.text = [NSString stringWithFormat:@"合计:¥%.2f",self.model.countyAgentPrice.floatValue * selectNum.integerValue];
            break;
        }
            default:
            break;
    }
    [((MerchandiseViewController *)self.myViewController) getShopCartNum];
    [UIView animateWithDuration:0.4 animations:^{
        self.masksView.hidden = YES;
    }];
}

//- (void)movePage:(UIButton *)sender{
//    MakeOrderViewController *vc = [[MakeOrderViewController alloc] init];
//    [self.myViewController.navigationController pushViewController:vc animated:YES];
//}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


- (void)segmentAction:(UISegmentedControl *)segment{
    if (self.currentSegmentIndex == segment.selectedSegmentIndex) {
        return;
    }
    switch (segment.selectedSegmentIndex) {
        case 0:{
            [self hideWebView];
            break;
        }
        case 1:{
            [self showWebView];
            break;
        }
        default:
            break;
    }
    self.currentSegmentIndex = segment.selectedSegmentIndex;
}

- (void)moveToShopCartPage{
    [self.myViewController.tabBarController setSelectedIndex:3];
    [self.myViewController.navigationController popToRootViewControllerAnimated:NO];
}

- (void)setModel:(MerchandiseDetailModel *)model{
    _model = model;
    _selectVC.model = model;
    [_mainTableView reloadData];
}

- (void)setComment:(MerchandiseUserComment *)comment{
    _comment = comment;
    [_mainTableView reloadData];
    
}

- (void)setTypeModelArray:(NSMutableArray *)typeModelArray{
    _typeModelArray = typeModelArray;
    _selectVC.dataArray = typeModelArray;
    [_mainTableView reloadData];
    
}

- (void)setGoodsImagesArray:(NSArray *)goodsImagesArray{
    _goodsImagesArray = goodsImagesArray;
    [_mainTableView reloadData];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [super hitTest:point withEvent:event];
}
@end
