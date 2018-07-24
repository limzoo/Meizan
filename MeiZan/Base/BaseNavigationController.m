//
//  BaseNavigationController.m
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UserLoginViewController.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationBar.translucent = NO;
    self.navigationBar.backIndicatorImage = [[UIImage imageNamed:@"返回键"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
     self.navigationBar.backIndicatorTransitionMaskImage = [[UIImage imageNamed:@"返回键"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    for (UIViewController *vc in self.viewControllers) {
        if ([vc isKindOfClass:[UserLoginViewController class]] && [viewController isKindOfClass:[UserLoginViewController class]]) {
            return;
        }
    }
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    if ([[self.viewControllers lastObject] isKindOfClass:[UserLoginViewController class]]) {
        [[self.viewControllers lastObject].tabBarController setSelectedIndex:0];
        return [super popToRootViewControllerAnimated:animated].firstObject;
    }else{
        return [super popViewControllerAnimated:animated];
    }
    return nil;
}

- (UIViewController *)loginSuccessPopViewControllerAnimated:(BOOL)animated{
    return [super popViewControllerAnimated:animated];
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
