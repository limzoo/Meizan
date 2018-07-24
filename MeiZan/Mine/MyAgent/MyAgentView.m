//
//  MyAgentView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/20.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "MyAgentView.h"
#import "MyAgentTableViewCell.h"
@interface MyAgentView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end
@implementation MyAgentView
- (void)createSubview{
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[MyAgentTableViewCell class] forCellReuseIdentifier:@"MyAgentTableViewCell"];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.mas_equalTo(self);
    }];
    self.tableView.tableFooterView = [[UIView alloc]init];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2 + self.childInfoArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            if (self.parentInfo.ID != nil) {
                if (self.parentInfo.allParentInfo.ID != nil) {
                    return 2;
                }else{
                    return 1;
                }
            }else{
                return 0;
            }
            break;
        }
        case 1:{
            return 1;
            break;
        }
        default:{
            if (self.childInfoArray.count != 0 && self.childInfoArray != nil) {
                MyAgentModel *model = self.childInfoArray[section - 2];
                return 1 + model.allChildInfoList.count; // 1是本体
            }else{
                return 0;
            }
            break;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            if (indexPath.row == 0) {
                if (self.parentInfo.allParentInfo.ID != nil) {
                    MyAgentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAgentTableViewCell"];
                       cell.indexPath = indexPath;
                    cell.model = self.parentInfo.allParentInfo;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.shouldHaveLeftInset = NO;
                    return cell;
                }else{
                    MyAgentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAgentTableViewCell"];
                       cell.indexPath = indexPath;
                    cell.model = self.parentInfo;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.shouldHaveLeftInset = NO;
                      return cell;
                }
            }else{
                MyAgentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAgentTableViewCell"];
                   cell.indexPath = indexPath;
                cell.model = self.parentInfo;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.shouldHaveLeftInset = NO;
                  return cell;
            }
            break;
        }
        case 1:{
                    MyAgentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAgentTableViewCell"];
                    cell.indexPath = indexPath;
                    cell.model = self.userInfo;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.shouldHaveLeftInset = NO;
            return cell;
            break;
        }
        default:{
            if (indexPath.row == 0) {
                MyAgentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAgentTableViewCell"];
                   cell.indexPath = indexPath;
                cell.model = self.childInfoArray[indexPath.section - 2];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.shouldHaveLeftInset = NO;
                  return cell;
            }else{
                MyAgentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAgentTableViewCell"];
                   cell.indexPath = indexPath;
                MyAgentModel *model = self.childInfoArray[indexPath.section - 2];
                cell.model = model.allChildInfoList[indexPath.row - 1];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.shouldHaveLeftInset = YES;
                  return cell;
            }
            break;
        }
    }
    return nil;
}

- (void)setParentInfo:(MyAgentModel *)parentInfo{
    _parentInfo = parentInfo;
    if (self.childInfoArray.count == 0 && self.parentInfo == nil) {
        [Tool showNoDataPicOnView:self.tableView withImage:[UIImage imageNamed:@"订单空"] title:@"暂无代理商" size:CGSizeMake(138, 140) topDistance:150];
    }else{
        [Tool hideNoDataPicOnView:self.tableView];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
         [self.tableView reloadData];
    });
   
}

- (void)setChildInfoArray:(NSArray *)childInfoArray{
    _childInfoArray = childInfoArray;
    if (_childInfoArray.count == 0 && self.parentInfo == nil) {
        [Tool showNoDataPicOnView:self.tableView withImage:[UIImage imageNamed:@"订单空"] title:@"暂无代理商" size:CGSizeMake(138, 140) topDistance:150];
    }else{
        [Tool hideNoDataPicOnView:self.tableView];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)setUserInfo:(MyAgentModel *)userInfo{
    _userInfo = userInfo;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
