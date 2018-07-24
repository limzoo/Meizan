//
//  AppDelegate.m
//  MeiZan
//
//  Created by 林宇 on 2017/12/25.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "WXApi.h"
#import "LaunchIntroductionView.h"
#import <Bugly/Bugly.h>
@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
    self.window.rootViewController = [[BaseTabBarController alloc] init];
    [WXApi registerApp:@"wxbe1d44827bc3bd87" ];
    LaunchIntroductionView *launch = [LaunchIntroductionView sharedWithImages:@[@"应用1",@"应用2",@"应用3"] buttonImage:nil buttonFrame:self.window.rootViewController.view.frame];
    launch.currentColor = [UIColor clearColor];
    [Bugly startWithAppId:@"8084364265"];
    return YES;
}

-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"successPay" object:nil];
                NSLog(@"支付成功");
                break;
                
            }
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
    if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *response = resp;
        switch (response.errCode) {
            case 0:{
                [MZAFNetwork GET:@"https://api.weixin.qq.com/sns/oauth2/access_token" params:@{@"appid":@"wxbe1d44827bc3bd87",@"secret":@"6fd4322684b5e062f7b8b586a305c5b8",@"code":response.code,@"grant_type":@"authorization_code"} success:^(NSURLSessionDataTask *task, id responseObject) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"WXLogin" object:nil userInfo:responseObject];
                } fail:^(NSURLSessionDataTask *task, NSError *error) {
                    ;
                }];
                break;
            }
                
            default:
                break;
        }
    }
}
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler{
    return YES;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(nonnull id)annotation{
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
     return [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
