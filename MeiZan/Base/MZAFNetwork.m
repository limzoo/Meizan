//
//  JingXuanAFNetwork.m
//  JingXuan
//
//  Created by sfs on 2017/12/21.
//  Copyright © 2017年 rhjt. All rights reserved.
//

#import "MZAFNetwork.h"
#import "UserLoginViewController.h"
#import "MineViewController.h"
static  AFHTTPSessionManager *manager = nil;

@interface MZAFNetwork ()
{
    CGError *err;
}
@end

@implementation MZAFNetwork
+(void)GET:(NSString *)url params:(NSDictionary *)params
   success:(CFResponseSuccess)success fail:(CFResponseFail)fail{
    
    AFHTTPSessionManager *manager = [self managerWithBaseURL:nil sessionConfiguration:NO];
    [manager GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [MZAFNetwork responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(void)GET:(NSString *)url baseURL:(NSString *)baseUrl params:(NSDictionary *)params
   success:(CFResponseSuccess)success fail:(CFResponseFail)fail{
    
    AFHTTPSessionManager *manager = [MZAFNetwork managerWithBaseURL:baseUrl sessionConfiguration:NO];
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        id dic = [MZAFNetwork responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
    
}

+(void)POST:(NSString *)url params:(NSDictionary *)params
    success:(CFResponseSuccess)success fail:(CFResponseFail)fail{
    
    
    AFHTTPSessionManager *manager = [MZAFNetwork managerWithBaseURL:nil sessionConfiguration:NO];
    
    // 设置超时时间为30秒
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    NSString *appUrl;
    NSData *userConfigData = [[NSUserDefaults standardUserDefaults] objectForKey:@"userConfig"];
    UserConfig *config = [NSKeyedUnarchiver unarchiveObjectWithData:userConfigData];
    if (config.userInfo.userId != 0) {
        appUrl = [url stringByAppendingString:[NSString stringWithFormat:@"?appId=%@&userId=%ld",[UIDevice currentDevice].identifierForVendor.UUIDString, config.userInfo.userId]];
    }else{
        appUrl = [url stringByAppendingString:[NSString stringWithFormat:@"?appId=%@",[UIDevice currentDevice].identifierForVendor.UUIDString]];
    }
    [manager POST:appUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        id dic = [MZAFNetwork responseConfiguration:responseObject];
        
        if ([[dic objectForKey:@"return_code"] isEqualToString:@"0002"]) {
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userConfig"];
            UIViewController *currentVC = [Tool getCurrentVC];
            UserLoginViewController *vc = [[UserLoginViewController alloc] init];
             vc.hidesBottomBarWhenPushed = YES;
            if ([currentVC isKindOfClass:[MineViewController class]]){
                success(task,dic);
               return;
            }
            if (![currentVC isKindOfClass:[UserLoginViewController class]]){
                [currentVC.navigationController pushViewController:vc animated:YES];
            }
        }
        
//        [NSThread sleepForTimeInterval:0.3f];
        
        success(task,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(task,error);
        
        
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        if (data != nil) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSString *return_code = dic[@"return_code"];
            
            if ([return_code isEqualToString:@"0401"]) {
                
                //                [Helper getToken];
                
                
            }
        }
        
        
    }];
}

+(void)noAnimationPOST:(NSString *)url params:(NSDictionary *)params
               success:(CFResponseSuccess)success fail:(CFResponseFail)fail{
    
    
    //    url = Chinese_Code_URL(url);
    
    AFHTTPSessionManager *manager = [MZAFNetwork managerWithBaseURL:nil sessionConfiguration:NO];
    
    // 设置超时时间为30秒
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [MZAFNetwork responseConfiguration:responseObject];
        
        success(task,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(task,error);
        
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        if (data != nil) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSString *return_code = dic[@"return_code"];
            
            if ([return_code isEqualToString:@"0401"]) {
                
                //                [Helper getToken];
                
            }
        }
        
        
    }];
}

+(void)POST:(NSString *)url baseURL:(NSString *)baseUrl params:(NSDictionary *)params
    success:(CFResponseSuccess)success fail:(CFResponseFail)fail{
    
    AFHTTPSessionManager *manager = [MZAFNetwork managerWithBaseURL:baseUrl sessionConfiguration:NO];
    
    // 设置超时时间为30秒
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [MZAFNetwork responseConfiguration:responseObject];
        
        success(task,dic);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        fail(task,error);
        
        NSData *data = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
        
        if (data != nil) {
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            
            //            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            NSString *return_code = dic[@"return_code"];
            
            if ([return_code isEqualToString:@"0401"]) {
                
                //                [Helper getToken];
                
            }
        }
        
        
    }];
}


+(void)uploadWithURL:(NSString *)url params:(NSDictionary *)params fileData:(NSData *)filedata name:(NSString *)name fileName:(NSString *)filename mimeType:(NSString *) mimeType progress:(CFProgress)progress success:(CFResponseSuccess)success fail:(CFResponseFail)fail{
    
    AFHTTPSessionManager *manager = [MZAFNetwork managerWithBaseURL:nil sessionConfiguration:NO];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [MZAFNetwork responseConfiguration:responseObject];
        success(task,dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(void)uploadWithURL:(NSString *)url
             baseURL:(NSString *)baseurl
              params:(NSDictionary *)params
            fileData:(NSData *)filedata
                name:(NSString *)name
            fileName:(NSString *)filename
            mimeType:(NSString *) mimeType
            progress:(CFProgress)progress
             success:(CFResponseSuccess)success
                fail:(CFResponseFail)fail{
    
    AFHTTPSessionManager *manager = [MZAFNetwork managerWithBaseURL:baseurl sessionConfiguration:YES];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:filedata name:name fileName:filename mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        id dic = [MZAFNetwork responseConfiguration:responseObject];
        
        success(task,dic);
        
        
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(task,error);
    }];
}

+(NSURLSessionDownloadTask *)downloadWithURL:(NSString *)url
                                 savePathURL:(NSURL *)fileURL
                                    progress:(CFProgress )progress
                                     success:(void (^)(NSURLResponse *, NSURL *))success
                                        fail:(void (^)(NSError *))fail{
    AFHTTPSessionManager *manager = [self managerWithBaseURL:nil sessionConfiguration:YES];
    
    NSURL *urlpath = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlpath];
    
    NSURLSessionDownloadTask *downloadtask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        progress(downloadProgress);
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return [fileURL URLByAppendingPathComponent:[response suggestedFilename]];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (error) {
            fail(error);
        }else{
            
            success(response,filePath);
        }
    }];
    
    [downloadtask resume];
    
    return downloadtask;
}

#pragma mark - Private

+(AFHTTPSessionManager *)managerWithBaseURL:(NSString *)baseURL  sessionConfiguration:(BOOL)isconfiguration{
    
    //    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //    manager =nil;
    
    //    NSURL *url = [NSURL URLWithString:baseURL];
    
    //    if (isconfiguration) {
    //        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url sessionConfiguration:configuration];
    //    }else{
    //        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:url];
    //    }
    manager = [self shareManager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    return manager;
}

+(id)responseConfiguration:(id)responseObject{
    
    NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    return dic;
}

+  (AFHTTPSessionManager *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [AFHTTPSessionManager manager];
    });
    return manager;
}
@end
