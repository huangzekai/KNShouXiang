//
//  KNCheckUpdateManager.m
//  KNMorseCode
//
//  Created by kenny on 2023/5/3.
//

#import "KNCheckUpdateManager.h"
#import "KNGlobalDefine.h"
#import <UIKit/UIKit.h>


@implementation KNCheckUpdateManager

//检查更新
//注意：不能发请求到appstore查看是否是最新版本，不然会被苹果拒绝
+ (void)checkForUpdate {
    NSURL *url = [NSURL URLWithString:ITUNES_URL];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
        
    }];
}

@end
