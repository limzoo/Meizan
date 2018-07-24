//
//  BaseViewController.m
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseView.h"
#import <objc/runtime.h>
@interface BaseViewController ()

@end

@implementation BaseViewController
- (void)setView:(UIView *)view{
    [super setView:view];
    if ([view isKindOfClass:[BaseView class]]) {
        ((BaseView *)view).myViewController = self;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;//底部tabbar不遮挡
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTitle:(NSString *)title{
    self.navigationController.navigationBar.titleTextAttributes =  @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size:18],NSForegroundColorAttributeName:TEXTCOLOR};
    [super setTitle:title];
}
//- (BOOL)object:(id)object hasPropertyNamed:(NSString *)objectName {
//    unsigned int methodCount = 0;
//    Ivar * ivars = class_copyIvarList([object class], &methodCount);
//    for (unsigned int i = 0; i < methodCount; i ++) {
//        Ivar ivar = ivars[i];
//        const char * name = ivar_getName(ivar);
//        NSString *nameStr = [NSString stringWithFormat:@"%s",name];
//        NSLog(@"%@",nameStr);
//        if ([nameStr isEqualToString:objectName]) {
//            return YES;
//        }
//    }
//    free(ivars);
//    return NO;
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
