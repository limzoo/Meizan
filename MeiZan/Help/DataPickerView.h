//
//  DataPickerView.h
//  rhjt
//
//  Created by sfs on 2017/4/13.
//  Copyright © 2017年 sfs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PickerViewShowStyle)  {
    StyleYearMonth = 0,
    StyleYearMonthDay,
    StyleHourMinute,
};

@protocol PICKVIEWDELEGATE <NSObject>

@optional
// 清除和完成按钮 点击事件
- (void)butControl:(NSInteger)tag ;

// 用户在选择器选择时
- (void)pickerViewSelectComponent:(NSInteger)component andRow:(NSInteger)row;

@end

@interface DataPickerView : UIView

@property (nonatomic, assign)PickerViewShowStyle pickerStyle;

@property (nonatomic, weak)id <PICKVIEWDELEGATE> pvDelegate;

@property (nonatomic, strong)NSArray *contentArray;

@property (nonatomic, copy)NSString *titleText;

@property (nonatomic, copy)NSString *subTitleText;

@property (nonatomic, strong)UIPickerView *pickerView;

@property (nonatomic, strong)UILabel *subTitleLabel;

@property (nonatomic, assign) long currentYear;

@property (nonatomic, assign) long currentMonth;

@property (nonatomic, assign) long currentDay;

- (void)reloadYear:(NSInteger)year andMonth:(NSInteger)month andDay:(NSInteger)day;

- (instancetype)initWithFrame:(CGRect)frame currentDate:(NSDate *)date;

- (void)reloadDay:(NSInteger)day ;

@end
