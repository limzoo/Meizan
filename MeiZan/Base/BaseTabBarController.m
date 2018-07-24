//
//  BaseTabBarController.m
//  JingXuan
//
//  Created by sfs on 2017/12/6.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "BaseTabBarController.h"

@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self tabbarVCInit];
}
- (void)tabbarVCInit{
    self.tabBar.barTintColor  = COLOR_RGB16(0xffffff);
    self.tabBar.tintColor = STYLECOLOR;
    //控制器的数组
    NSArray *vcNames=@[@"HomepageViewController",
                       @"TypePageViewController",
                       @"ExplorationViewController",
                       @"ShopCartViewController",
                       @"MineViewController"];
    
    NSArray *titles=@[@"美赞",
                      @"分类",
                      @"消息",
                      @"购物车",
                      @"我的"];
    //控制器假如导航栏的数组
    NSMutableArray *vcs =[[NSMutableArray alloc]init];
    
    for (int i = 0; i < vcNames.count; i++) {
        
        UIViewController *vc =[[NSClassFromString(vcNames[i])alloc]init];
        
        //        vc.tabBarItem.tag = 10+i;
        
        // 设置头部的文字
        
        BaseNavigationController *nav =[[BaseNavigationController alloc] initWithRootViewController:vc];
        
        if (i == 0 || i == 1 || i== 4) {
            nav.navigationBar.hidden = YES;
        }
        nav.tabBarItem.title = titles[i];
        UIImage *unSelectedImage = [UIImage imageNamed:[(NSString *)titles[i] stringByAppendingString:@"_unselected"]];
        nav.tabBarItem.image = unSelectedImage;
        UIImage *image = [UIImage imageNamed:[(NSString *)titles[i] stringByAppendingString:@"_selected"]];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = image;
        [vcs addObject:nav];
        
        nav.navigationBar.barTintColor = [UIColor whiteColor];
    }
    
    
    self.viewControllers =vcs;
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
