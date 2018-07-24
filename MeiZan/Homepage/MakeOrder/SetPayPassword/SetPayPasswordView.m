//
//  SetPayPasswordView.m
//  MeiZan
//
//  Created by 林宇 on 2018/1/26.
//  Copyright © 2018年 rhjt. All rights reserved.
//

#import "SetPayPasswordView.h"
#import "GLTextField.h"
#import "UIView+category.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//密码位数
static NSInteger const kDotsNumber = 6;

//假密码点点的宽和高  应该是等高等宽的正方形 方便设置为圆
static CGFloat const kDotWith_height = 10;
@interface SetPayPasswordView()<UITextFieldDelegate>

//密码输入文本框
@property (nonatomic,strong) GLTextField *passwordField;
//用来装密码圆点的数组
@property (nonatomic,strong) NSMutableArray *passwordDotsArray;
//默认密码
@property (nonatomic,strong,readonly) NSString *password;
@property (nonatomic, strong) UILabel *const_announceLabel;
@property (nonatomic, assign) BOOL isFirstTime;
@property (nonatomic, strong) NSString *firstTimepassword;
@end
@implementation SetPayPasswordView
- (void)createSubview{
    self.backgroundColor = COLOR_RGB16(0xfafafa);
    self.isFirstTime = YES;
    self.const_announceLabel = [UILabel initWithCustomFontOfSize: [UIFont fontWithName:@"PingFangSC-Regular" size:18] color:TITLECOLOR text:@"输入新交易密码"];
    [self addSubview:self.const_announceLabel];
    [self.const_announceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(63);
        make.height.mas_equalTo(20);
    }];
    
    [self addSubview:self.passwordField];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(46);
        make.width.mas_equalTo(343);
        make.top.mas_equalTo(self.const_announceLabel.mas_bottom).offset(48);
        
    }];
//    [self.passwordField becomeFirstResponder];
    
    [self addDotsViews];
}

#pragma mark == private method
- (void)addDotsViews
{
    //密码输入框的宽度
    CGFloat passwordFieldWidth = CGRectGetWidth(self.passwordField.frame);
    //六等分 每等分的宽度
    CGFloat password_width = passwordFieldWidth / kDotsNumber;
    //密码输入框的高度
    CGFloat password_height = CGRectGetHeight(self.passwordField.frame);
    
    for (int i = 0; i < kDotsNumber; i ++)
    {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(i * password_width, 0, 1, password_height)];
        line.backgroundColor = UIColorFromRGB(0xdddddd);
        [self.passwordField addSubview:line];
        
        //假密码点的x坐标
        CGFloat dotViewX = (i + 1)*password_width - password_width / 2.0 - kDotWith_height / 2.0;
        CGFloat dotViewY = (password_height - kDotWith_height) / 2.0;
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(dotViewX, dotViewY, kDotWith_height, kDotWith_height)];
        dotView.backgroundColor = UIColorFromRGB(0x222222);
        [dotView setCornerRadius:kDotWith_height/2.0];
        dotView.hidden = YES;
        [self.passwordField addSubview:dotView];
        [self.passwordDotsArray addObject:dotView];
    }
}

- (void)cleanPassword
{
    _passwordField.text = @"";
    
    [self setDotsViewHidden];
}

//将所有的假密码点设置为隐藏状态
- (void)setDotsViewHidden
{
    for (UIView *view in _passwordDotsArray)
    {
        [view setHidden:YES];
    }
}


#pragma mark == UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //删除键
    if (string.length == 0)
    {
        return YES;
    }
    
    if (_passwordField.text.length >= kDotsNumber)
    {
        return NO;
    }
    
    return YES;
}

#pragma mark == event response
- (void)passwordFieldDidChange:(UITextField *)field
{
    [self setDotsViewHidden];
    
    for (int i = 0; i < _passwordField.text.length; i ++)
    {
        if (_passwordDotsArray.count > i )
        {
            UIView *dotView = _passwordDotsArray[i];
            [dotView setHidden:NO];
        }
    }
    
    
    if (_passwordField.text.length == 6)
    {
        if (self.isFirstTime) {
            self.firstTimepassword = _passwordField.text;
            [self cleanPassword];
            self.isFirstTime = NO;
            self.const_announceLabel.text = @"再次输入密码";
        }else{
            if([_passwordField.text isEqualToString:self.firstTimepassword]){
                [self setPayPassword];
            }else{
                [Tool showMessage:@"两次输入密码不一致" duration:3 atCenter:YES];
                self.isFirstTime = YES;
                self.const_announceLabel.text = @"输入交易密码";
                [self cleanPassword];
            }
        }
        
        //        if ([password isEqualToString:_password])
        //        {
        //            NSLog(@" 打印信息  密码正确");
        //        }
        //        else
        //        {
        //            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"密码错误，请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        //
        //            // Create the actions.
        //            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        //
        //                [self cleanPassword];
        //
        //            }];
        //
        //            // Add the actions.
        //            [alertController addAction:cancelAction];
        //
        //            [self presentViewController:alertController animated:YES completion:nil];
        //        }
    }
}

- (void)setPayPassword{
    [MZAFNetwork POST:HOME_URL(@"/userInfo/updatePayPassword") params:@{@"payPassword":self.firstTimepassword} success:^(NSURLSessionDataTask *task, id responseObject) {
        [Tool showMessage:[responseObject objectForKey:@"return_msg"] duration:3];
        if ([[responseObject objectForKey:@"return_code"]isEqualToString:@"0000"]) {
            UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"]];
            config.isPayPassword = @"1";
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:config] forKey:@"userConfig"];
            [self.myViewController.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSURLSessionDataTask *task, NSError *error) {
        ;
    }];
}
#pragma mark == 懒加载
- (GLTextField *)passwordField
{
    if (nil == _passwordField)
    {
        _passwordField = [[GLTextField alloc] initWithFrame:CGRectMake(14, 195, 347, 46)];
        _passwordField.layer.cornerRadius = 4;
        _passwordField.layer.masksToBounds = YES;
        _passwordField.delegate = (id)self;
        _passwordField.backgroundColor = [UIColor whiteColor];
        //将密码的文字颜色和光标颜色设置为透明色
        //之前是设置的白色 这里有个问题 如果密码太长的话 文字和光标的位置如果到了第一个黑色的密码点的时候 就看出来了
        _passwordField.textColor = [UIColor clearColor];
        _passwordField.tintColor = [UIColor clearColor];
        [_passwordField setBorderColor:UIColorFromRGB(0xdddddd) width:1];
        _passwordField.keyboardType = UIKeyboardTypeNumberPad;
        _passwordField.secureTextEntry = YES;
        [_passwordField addTarget:self action:@selector(passwordFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordField;
}

- (NSMutableArray *)passwordDotsArray
{
    if (nil == _passwordDotsArray)
    {
        _passwordDotsArray = [[NSMutableArray alloc] initWithCapacity:kDotsNumber];
    }
    return _passwordDotsArray;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
