//
//  KNAppConfigManager.m
//  KNUnflodTextProject
//
//  Created by kenny on 2023/7/13.
//

#import "KNAppConfigManager.h"
#import <AFNetworking/AFNetworking.h>
#import "NSDictionary+JKSafeAccess.h"

#define CONFIG_URL @"https://chaoshandictionary-1251103646.cos.ap-guangzhou.myqcloud.com/shouxiangConfig.json"

@interface KNAppConfigManager ()

@end


@implementation KNAppConfigManager

+ (instancetype)sharedInstance {
    static KNAppConfigManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)requestAppConfigSuccess:(void (^)(NSString *message))successHandler failure:(void (^)(NSError *error))failureHandler {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:CONFIG_URL parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)responseObject;
            NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            NSArray *array = [dict jk_arrayForKey:@"appVersion"];
            if ([array containsObject:version]) {
                NSString *message = [dict objectForKey:@"message"];
                if (successHandler) {
                    successHandler(message);
                }
            }
        }
        
        NSLog(@"请求配置成功:%@",[(NSDictionary *)responseObject description]);
        // 处理JSON数据
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求配置失败: %@", error.localizedDescription);
        if (failureHandler) {
            failureHandler(error);
        }
    }];
}

@end
