//
//  LMSelectorViewController.m
//  LMAddressSelector
//
//  Created by sfs on 2017/12/15.
//  Copyright © 2017年 limzoo. All rights reserved.
//

#import "LMSelectorViewController.h"

@interface LMSelectorViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) NSDictionary *dataDict;

@property (nonatomic, strong) NSArray *provinceArray;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *blockArray;
@property (nonatomic, strong) NSArray *currentArray;

@property (nonatomic, strong) UIButton *province;
@property (nonatomic, strong) UIButton *city;
@property (nonatomic, strong) UIButton *block;
@property (nonatomic, strong) UIButton *completeButton;

@property (nonatomic, strong) UIView *slideView;

@property (nonatomic, strong) UITableView *selectTableView;

@property (nonatomic, assign) NSUInteger currentIndex;//0:province,1:city,2:block
@property (nonatomic, assign) BOOL didFinished;
@end

@implementation LMSelectorViewController
- (instancetype)init{
    self = [super init];
    if (self) {
        [self configInitial];
        [self createSubview];
    }
    return self;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.selectTableView setFrame:CGRectMake(0, 45, self.view.bounds.size.width, self.view.bounds.size.height - 45)];
}
- (void)configInitial{
    self.currentIndex = 0;
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.dataDict = [NSDictionary dictionaryWithContentsOfFile:path];
    self.provinceArray = [self.dataDict allKeys];
    self.currentArray = self.provinceArray;
    self.didFinished = NO;
}
- (void)createSubview{
    UIView *insetLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, 1)];
    insetLineView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    [self.view addSubview:insetLineView];
    
    self.completeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.completeButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.completeButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.completeButton addTarget:self action:@selector(finishedSelect:) forControlEvents:UIControlEventTouchUpInside];
    [self.completeButton setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    self.completeButton.frame = CGRectMake(self.view.bounds.size.width - 80, 0, 80, 44);
    [self.view addSubview:self.completeButton];
    
    NSString *tempStr = @"请选择";
    CGSize strSize = [tempStr sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:15]}];
    
    self.province = [UIButton buttonWithType:UIButtonTypeCustom];
    self.province.tag = 100;
    self.province.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.province setTitle:@"请选择" forState:UIControlStateNormal];
    [self.province setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    [self.province addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.province.frame = CGRectMake(0, 0, strSize.width + 8, 44);
    [self.view addSubview:self.province];
    
    self.city = [UIButton buttonWithType:UIButtonTypeCustom];
    self.city.tag = 101;
    self.city.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.city setTitle:@"请选择" forState:UIControlStateNormal];
    [self.city addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.city setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    //    self.city.frame = CGRectMake(100, 0, 100, 44);
    self.city.frame = CGRectZero;
    self.city.hidden = YES;
    [self.view addSubview:self.city];
    
    self.block = [UIButton buttonWithType:UIButtonTypeCustom];
    self.block.tag = 102;
    self.block.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    [self.block setTitle:@"请选择" forState:UIControlStateNormal];
    [self.block addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.block setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    //    self.block.frame = CGRectMake(200, 0, 100, 44);
    self.block.frame = CGRectZero;
    self.block.hidden = YES;
    [self.view addSubview:self.block];
    
    self.slideView = [[UIView alloc] initWithFrame:CGRectZero];
    self.slideView.backgroundColor =  [UIColor colorWithRed:246/255.0 green:171/255.0 blue:0/255.0 alpha:1/1.0];
    self.slideView.frame = CGRectMake(self.province.center.x - 25, 43, 50, 2);
    [self.view addSubview:self.slideView];
    
    self.selectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, self.view.bounds.size.width, self.view.bounds.size.height - 45)];
    [self.view addSubview:self.selectTableView];
    self.selectTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.selectTableView.delegate = self;
    self.selectTableView.dataSource = self;
    [self.selectTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (self.currentIndex) {
        case 0:
            return self.provinceArray.count;
            break;
        case 1:
            return self.cityArray.count;
            break;
        case 2:
            return self.blockArray.count;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.currentArray[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *currentSelectTitle = self.currentArray[indexPath.row];
    CGSize titleSize = [currentSelectTitle sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:15]}];
    CGSize strSize = [@"请选择" sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:15]}];
    UIButton *currentButton = [self.view viewWithTag:100 + self.currentIndex];
    __weak typeof(self) weakSelf = self;
    switch (self.currentIndex) {
        case 0:{
            self.cityArray = [((NSDictionary *)[((NSArray *)[self.dataDict objectForKey:currentSelectTitle]) firstObject]) allKeys];
            self.currentArray = self.cityArray;
            self.currentIndex ++;
            UIButton *nextButton = [self.view viewWithTag:self.currentIndex + 100];
            [currentButton setTitle:currentSelectTitle forState:UIControlStateNormal];
            [UIView animateWithDuration:0.5 animations:^{
                [weakSelf.province setFrame:CGRectMake(0, 0, titleSize.width + 8, 44)];
                [nextButton setFrame:CGRectMake(weakSelf.province.frame.size.width, 0, strSize.width + 20, 44)];
                [nextButton setHidden:NO];
                [weakSelf.selectTableView reloadData];
                [weakSelf.slideView setCenter:CGPointMake(weakSelf.city.center.x, 43)];
                [weakSelf.selectTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }];
            break;
        }
        case 1:{
            self.blockArray = [((NSDictionary *)[((NSArray *)[self.dataDict objectForKey:self.province.currentTitle]) firstObject]) objectForKey:currentSelectTitle];
            self.currentArray = self.blockArray;
            self.currentIndex ++;
            UIButton *nextButton = [self.view viewWithTag:self.currentIndex + 100];
            [currentButton setTitle:currentSelectTitle forState:UIControlStateNormal];
            [UIView animateWithDuration:0.5 animations:^{
                [weakSelf.city setFrame:CGRectMake(weakSelf.province.frame.size.width, 0, titleSize.width + 8, 44)];
                [nextButton setFrame:CGRectMake(weakSelf.city.frame.size.width + weakSelf.city.frame.origin.x, 0, strSize.width + 8, 44)];
                [nextButton setHidden:NO];
                [weakSelf.slideView setCenter:CGPointMake(weakSelf.block.center.x, 43)];
                [weakSelf.selectTableView reloadData];
                [weakSelf.selectTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }];
            break;
        }
        case 2:{
            [currentButton setTitle:currentSelectTitle forState:UIControlStateNormal];
            [UIView animateWithDuration:0.5 animations:^{
                if (weakSelf.city.frame.origin.x + weakSelf.city.frame.size.width + titleSize.width + 8> self.completeButton.frame.origin.x) {
                    [weakSelf.block setFrame:CGRectMake(weakSelf.city.frame.size.width + weakSelf.city.frame.origin.x, 0, weakSelf.completeButton.frame.origin.x - weakSelf.city.frame.size.width - weakSelf.city.frame.origin.x, 44)];
                }else{
                    [weakSelf.block setFrame:CGRectMake(weakSelf.city.frame.origin.x + weakSelf.city.frame.size.width, 0, titleSize.width + 8, 44)];
                }
                
                [weakSelf.slideView setCenter:CGPointMake(weakSelf.block.center.x, 43)];
            } completion:^(BOOL finished) {
                if (finished) {
                    self.didFinished = YES;
                    [self.completeButton setTitle:@"完成" forState:UIControlStateNormal];
                }
            }];
            break;
        }
        default:
            break;
    }
}

- (void)selectButtonAction:(UIButton *)sender{
    NSUInteger selectButtonIndex = sender.tag - 100;
    for (int i = 0; self.currentIndex - i != selectButtonIndex; i++) {
        UIButton *hideButton = [self.view viewWithTag:self.currentIndex - i + 100];
        [hideButton setTitle:@"请选择" forState:UIControlStateNormal];
        [hideButton setHidden:YES];
    }
    self.currentIndex = sender.tag - 100;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        [weakSelf.slideView setCenter:CGPointMake(sender.center.x, 43)];
    }];
    switch (sender.tag - 100) {
        case 0:
            self.currentArray = self.provinceArray;
            self.didFinished = NO;
            [self.completeButton setTitle:@"取消" forState:UIControlStateNormal];
            break;
        case 1:
            self.currentArray = self.cityArray;
              [self.completeButton setTitle:@"取消" forState:UIControlStateNormal];
            self.didFinished = NO;
            break;
        case 2:
            self.currentArray = self.blockArray;
            break;
        default:
            break;
    }
    [self.selectTableView reloadData];
}

- (void)finishedSelect:(UIButton *)sender{
    __weak typeof(self) weakSelf = self;
    if (!self.didFinished) {
        [self.delegate selector:weakSelf didNotFinishSelectAddIndex:self.currentIndex];
        return;
    }
    [self.delegate selector:weakSelf didFinishSelectWithProvince:self.province.currentTitle city:self.city.currentTitle district:self.block.currentTitle];
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
