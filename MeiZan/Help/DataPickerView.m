
//  DataPickerView.m
//  rhjt
//
//  Created by sfs on 2017/4/13.
//  Copyright © 2017年 sfs. All rights reserved.
//

#import "DataPickerView.h"

@interface DataPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong)UIView *butBackView;

@property (nonatomic, strong)UIButton *removeBut;

@property (nonatomic, strong)UIButton *completeBut;

@property (nonatomic, strong)UIView *selectView;

@property (nonatomic, strong) NSDate *currenDate;

@property (nonatomic, strong) NSMutableArray *yearArray;

@property (nonatomic, strong) NSMutableArray *monthArray;

@property (nonatomic, strong) NSMutableArray *dayArray;

@property (nonatomic, assign) NSInteger selectYearIndex;

@property (nonatomic, assign) NSInteger selectMonthIndex;

@property (nonatomic, assign) NSInteger selectDayIndex;

@end

@implementation DataPickerView
- (instancetype)initWithFrame:(CGRect)frame currentDate:(NSDate *)date{
    self = [super initWithFrame:frame];
    if (self) {
        self.currenDate = date;
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];//设置成中国阳历
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;//这句我也不明白具体时用来做什么。。。
        comps = [calendar components:unitFlags fromDate:date];
        
        long day=[comps day];//获取日期对应的长整形字符
        long year=[comps year];//获取年对应的长整形字符
        long month=[comps month];//获取月对应的长整形字符
        self.currentDay = day;
        self.currentMonth = month;
        self.currentYear = year;
        self.yearArray = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%ld",year],[NSString stringWithFormat:@"%ld",year + 1]]];
        
        self.monthArray = [NSMutableArray array];
        for (long i = month; i < 13; i++) {
            [self.monthArray addObject:[NSString stringWithFormat:@"%ld",i]];
        }
        self.dayArray = [NSMutableArray array];
        long startDay = day;
        long overDay = 31;
        
        if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12) {
            overDay = 31;
        }else if(month == 4 || month == 6 || month == 9 || month == 11) {
            overDay = 30;
        }else{
            overDay = (year % 4 == 0 ? 29 : 28);
        }
        
        for (long i = startDay ; i < overDay + 1 ; i ++) {
            [self.dayArray addObject:[NSString stringWithFormat:@"%ld",i]];
        }
        self.layer.cornerRadius = 5;
        
        self.layer.masksToBounds = YES;
        
        self.clipsToBounds = YES;
        
        self.backgroundColor =  [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1/1.0];
        
        [self createPickerView];
        
          _subTitleLabel.text = [NSString stringWithFormat:@"%ld年 %ld月 %ld日",year,month,day + 1];
        self.selectYearIndex = 0;
        self.selectMonthIndex = 0;
        self.selectDayIndex = 0;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.cornerRadius = 5;
        
        self.layer.masksToBounds = YES;
        
        self.clipsToBounds = YES;
        
        self.backgroundColor =  [UIColor colorWithRed:250/255.0 green:250/255.0 blue:250/255.0 alpha:1/1.0];
        
        [self createPickerView];
        
    }
    return self;
}

- (void)createPickerView {
    
    // 选择日期，选择时间
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 21, self.bounds.size.width, 16)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"选择日期";
    _titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    _titleLabel.textColor =  [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1/1.0];
    [self addSubview:_titleLabel];
    
    // 具体时间
    _subTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleLabel.frame.origin.y + _titleLabel.bounds.size.height + 14, self.bounds.size.width, 15)];
    
    _subTitleLabel.textAlignment = NSTextAlignmentCenter;
    _subTitleLabel.text = @"当前日期";
    _subTitleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    _subTitleLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0];
    
    [self addSubview:_subTitleLabel];
    
    
    
    // 选择器最底层视图
    UIView *pickerViewBackView = [[UIView alloc]initWithFrame:CGRectMake(28, 85, self.bounds.size.width - 28 * 2, 160)];
    
    pickerViewBackView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1/1.0];
    
    [self addSubview:pickerViewBackView];
    
    
    
    // 白色视图
    _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, pickerViewBackView.bounds.size.height/2.0 - 20, pickerViewBackView.frame.size.width, 40)];
    
    _selectView.backgroundColor = [UIColor whiteColor];
    
    _selectView.userInteractionEnabled = NO;
    
    [pickerViewBackView addSubview:_selectView];
    
    //白色试图上的文字
    UILabel *year = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _selectView.bounds.size.width / 3, 50)];
    
    year.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    year.textColor = [UIColor colorWithRed:246/255.0 green:171/255.0 blue:0/255.0 alpha:1/1.0];
    
    UILabel *month = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _selectView.bounds.size.width / 3, 50)];
    
    year.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    year.textColor = [UIColor colorWithRed:246/255.0 green:171/255.0 blue:0/255.0 alpha:1/1.0];
    [_selectView addSubview:year];
    // 滑动
    _pickerView  = [[UIPickerView alloc]initWithFrame:pickerViewBackView.bounds];
    
    _pickerView.backgroundColor = [UIColor clearColor];
    
    _pickerView.delegate = self;
    
    _pickerView.dataSource = self;
    
    _pickerView.showsSelectionIndicator = NO;
    
    [pickerViewBackView addSubview:_pickerView];
    
    
    // 线左
    UIView *LeftLine = [[UIView alloc] initWithFrame:CGRectMake(pickerViewBackView.frame.origin.x - 2, pickerViewBackView.frame.origin.y, 2,pickerViewBackView.bounds.size.height)];
    
    LeftLine.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1/1.0];
    
    [self addSubview:LeftLine];
    
    // 线橙
    UIView *lineOrange = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 40)];
    lineOrange.center = LeftLine.center;
    lineOrange.backgroundColor =  [UIColor colorWithRed:246/255.0 green:171/255.0 blue:0/255.0 alpha:1/1.0];
    
    [self addSubview:lineOrange];
    
    
    // 按钮背景
    _butBackView = [[UIView alloc]initWithFrame:CGRectMake(pickerViewBackView.frame.origin.x, pickerViewBackView.frame.origin.y + pickerViewBackView.bounds.size.height + 34, pickerViewBackView.bounds.size.width, 40)];
    _butBackView.layer.masksToBounds = YES;
    _butBackView.backgroundColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1/1.0];
    _butBackView.layer.cornerRadius = 20;
    _butBackView.layer.borderWidth = 0.5;
    _butBackView.layer.borderColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1/1.0].CGColor;
    
    
    [self addSubview:_butBackView];
    
    // 取消
    _removeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _removeBut.backgroundColor = [UIColor whiteColor];
    _removeBut.frame = CGRectMake(0, 0, _butBackView.bounds.size.width/2 - 0.5, _butBackView.bounds.size.height);
    [_removeBut setTitle:@"取消" forState:UIControlStateNormal];
    [_removeBut setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    
    _removeBut.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    
    [_removeBut addTarget:self action:@selector(removeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_butBackView addSubview:_removeBut];
    
    // 完成
    _completeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _completeBut.backgroundColor = [UIColor whiteColor];
    
    _completeBut.frame = CGRectMake(_butBackView.bounds.size.width/2 + 0.5, 0, _butBackView.bounds.size.width/2 - 0.5, _butBackView.bounds.size.height);
    [_completeBut setTitle:@"确定" forState:UIControlStateNormal];
    [_completeBut setTitleColor:[UIColor colorWithRed:246/255.0 green:171/255.0 blue:0/255.0 alpha:1/1.0] forState:UIControlStateNormal];
    
    _completeBut.titleLabel.font =  [UIFont fontWithName:@"PingFangSC-Regular" size:12];
    
    [_completeBut addTarget:self action:@selector(nextStepAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_butBackView addSubview:_completeBut];
    
    _completeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    
}


// 按钮点击事件
- (void)removeAction:(UIButton *) button {
    [self.pvDelegate butControl:0];
}

- (void)nextStepAction:(UIButton *) button {
    [self.pvDelegate butControl:1];
}

- (void)reloadDay:(NSInteger)day {
    
    [_pickerView selectRow:day inComponent:2 animated:YES];
    
    UILabel* pickerLabel = (UILabel*)[_pickerView viewForRow:day forComponent:2];
    
    //    pickerLabel.textColor = BackgroundColor;
    
    _subTitleLabel.text = _subTitleText;
    
}

// 获取当前日期，刷新日期
- (void)reloadYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day {
    
    
    if (year>=0) {
        
        [_pickerView selectRow:year inComponent:0 animated:0];
        [self pickerView:_pickerView didSelectRow:year inComponent:0];
        
        
    }
    
    if (month>=0) {
        
        [_pickerView selectRow:month inComponent:1 animated:0];
        
        [self pickerView:_pickerView didSelectRow:month inComponent:1];
        
    }
    
    if (day>=0) {
        
        [_pickerView selectRow:day inComponent:2 animated:0];
        
        [self pickerView:_pickerView didSelectRow:day inComponent:2];
        
    }
    
    _titleLabel.text = _titleText;
    
    _subTitleLabel.text = _subTitleText;
    
}



#pragma mark UIPickerView DataSource Method 数据源方法

//指定pickerview有几个表盘
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;//第一个展示字母、第二个展示数字
}

//指定每个表盘上有几行数据
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    //    NSArray *array = _contentArray[component];
    //
    //    return array.count;
    switch (component) {
        case 0:
            return self.yearArray.count;
            break;
        case 1:
            return self.monthArray.count;
            break;
        case 2:
            return self.dayArray.count;
            break;
        default:
            break;
    }
    return 0;
}

#pragma mark UIPickerView Delegate Method 代理方法

//指定每行如何展示数据（此处和tableview类似）
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    switch (component) {
        case 0:
            if (self.selectYearIndex == row) {
                return [NSString stringWithFormat:@"%@ 年",self.yearArray[row]];
            }
            return self.yearArray[row];
            break;
        case 1:
            if (self.selectMonthIndex == row) {
                return [NSString stringWithFormat:@"%@ 月",self.monthArray[row]];
            }
            return self.monthArray[row];
            break;
        case 2:
            if (self.selectDayIndex == row) {
                return [NSString stringWithFormat:@"%@ 日",self.dayArray[row]];
            }
            return self.dayArray[row];
            break;
        default:
            break;
    }
    return 0;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectYearIndex = row;
    }
    if (component == 1) {
        self.selectMonthIndex = row;
    }
    if (component == 2) {
        self.selectDayIndex = row;
    }
    UILabel* pickerLabel = (UILabel*)[pickerView viewForRow:row forComponent:component];
    pickerLabel.textColor = [UIColor colorWithRed:246/255.0 green:171/255.0 blue:0/255.0 alpha:1/1.0];
    
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;//这句我也不明白具体时用来做什么。。。
    comps = [calendar components:unitFlags fromDate:self.currenDate];
    
    long day=[comps day];//获取日期对应的长整形字符串
    long year=[comps year];//获取年对应的长整形字符串
    long month=[comps month];//获取月对应的长整形字符串
    switch (component) {
        case 0:{
             self.currentYear = [NSString stringWithFormat:@"%@", self.yearArray[row]].integerValue;
            if (row == 0) {
                self.monthArray = [NSMutableArray array];
                for (long i = month; i < 13; i++) {
                    [self.monthArray addObject:[NSString stringWithFormat:@"%ld",i]];
                }
                self.monthArray = [NSMutableArray array];
                for (long i = month; i < 13; i++) {
                    [self.monthArray addObject:[NSString stringWithFormat:@"%ld",i]];
                }
            }else{
                self.monthArray = [NSMutableArray array];
                for (long i = 1; i < 13; i++) {
                    [self.monthArray addObject:[NSString stringWithFormat:@"%ld",i]];
                }
            }
//            [pickerView reloadComponent:component + 1];
//            [pickerView reloadAllComponents];
            break;
        }
        case 1:{
            self.currentMonth = [NSString stringWithFormat:@"%@", self.monthArray[row]].integerValue;
            long startDay = 1;
            long overDay = 31;
            if (self.currentYear == year && self.currentMonth == month) {
                startDay = day + 1;//
            }
            if (self.currentMonth == 1 || self.currentMonth == 3 || self.currentMonth == 5 || self.currentMonth == 7 || self.currentMonth == 8 || self.currentMonth == 10 || self.currentMonth == 12) {
                overDay = 31;
            }else if(self.currentMonth == 4 || self.currentMonth == 6 || self.currentMonth == 9 || self.currentMonth == 11) {
                overDay = 30;
            }else{
                overDay = (year % 4 == 0 ? 29 : 28);
            }
            self.dayArray = [NSMutableArray array];
            for (long i = startDay ; i < overDay + 1 ; i ++) {
                [self.dayArray addObject:[NSString stringWithFormat:@"%ld",i]];
            }
//            [pickerView reloadComponent:component + 1];
            break;
        }
        case 2:{
            self.currentDay = [NSString stringWithFormat:@"%@", self.dayArray[row]].integerValue;
            break;
        }
        default:
            break;
    }
    
     self.subTitleLabel.text = [NSString stringWithFormat:@"%ld年 %ld月 %ld日",self.currentYear ,self.currentMonth,self.currentDay];
    [pickerView reloadAllComponents];
    [self.pvDelegate pickerViewSelectComponent:component andRow:row];
    
}

#pragma mark 给pickerview设置字体大小和颜色等
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    //    可以通过自定义label达到自定义pickerview展示数据的方式
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        
        if (component == 0) {
            if (row == self.selectYearIndex) {
                pickerLabel.textColor = STYLECOLOR;
            }
        }else if (component == 1){
            if (row == self.selectMonthIndex) {
                pickerLabel.textColor = STYLECOLOR;
            }
        }else if (component == 2){
            if (row == self.selectDayIndex) {
                pickerLabel.textColor = STYLECOLOR;
            }
        }else{
            pickerLabel.textColor = [UIColor blackColor];
        }
        pickerLabel.font = [UIFont systemFontOfSize:14];
    }
    ((UILabel *)[pickerView.subviews objectAtIndex:1]).backgroundColor = [UIColor whiteColor];
    
    ((UILabel *)[pickerView.subviews objectAtIndex:2]).backgroundColor = [UIColor whiteColor];
    
    pickerLabel.text= [self pickerView:pickerView titleForRow:row forComponent:component];//调用上一个委托方法，获得要展示的title
    
    return pickerLabel;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 162/5.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return pickerView.bounds.size.width/3.0;
}

@end
