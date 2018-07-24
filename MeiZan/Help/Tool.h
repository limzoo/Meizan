//
//  Tool.h
//  JingXuan
//
//  Created by sfs on 2017/12/12.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
@interface Tool : NSObject
+ (NSString *) md5:(NSString *)str;
+ (CGFloat)calculateCellHeightWithArray:(NSArray<NSString *> *)array width:(CGFloat)width;
+ (NSString *)getNetworkIPAddress;
+ (NSString *)getLocalIPAddress:(BOOL)preferIPv4;
+ (NSDictionary *)getIPAddresses ;
+ (UIViewController *)getCurrentVC;

+ (UIImage*) imageWithColor:(UIColor*)color andHeight:(CGFloat)height;
+(void)showMessage:(NSString *)message duration:(NSTimeInterval)time;
+(void)showMessage:(NSString *)message duration:(NSTimeInterval)time atCenter:(BOOL)atCenter;

+ (void)showNoDataPicOnView:(UIView *)view withImage:(UIImage *)image title:(NSString *)title size:(CGSize)size topDistance:(CGFloat)distance;
+ (void)hideNoDataPicOnView:(UIView *)view;

+ (BOOL)isValidateMobile:(NSString *)mobile;
+ (BOOL)isValidatIP:(NSString *)ipAddress;
+ (BOOL)isPoint:(CGPoint)point inFrame:(CGRect)rect;
@end
