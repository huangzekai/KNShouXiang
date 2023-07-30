//
//  KNMonitorManager.m
//  KNKeyboard
//  监控上报类
//  Created by kenny on 2023/7/13.
//

#import "KNMonitorManager.h"
#import <UMCommon/UMCommon.h>
#import <UMCommon/MobClick.h>
#import <UMDevice/UMZid.h>

//友盟appkey
#define APP_KEY @"64c6155da1a164591b5c7965"
#define APPSTORE @"App Store"

@implementation KNMonitorManager

+ (void)initMonitor {
    [UMConfigure initWithAppkey:APP_KEY channel:APPSTORE];
    
    NSString * deviceID =[UMConfigure deviceIDForIntegration];
    NSLog(@"集成测试的deviceID:%@", deviceID);
}

//开始页面浏览
+ (void)beginMonitorPage:(NSString *)name {
    if (name.length <= 0) {
        return;
    }
    [MobClick beginLogPageView:name];
    NSLog(@"开始页面统计:%@", name);
}

//结束页面浏览
+ (void)endMonitorPage:(NSString *)name {
    if (name.length <= 0) {
        return;
    }
    [MobClick endLogPageView:name];
    NSLog(@"结束页面统计:%@", name);
}

+ (void)clickMonitor:(NSInteger)index {
    NSString *uid = [UMZid getZID];
    uid = uid ? : @"user";
    NSString *level = [NSString stringWithFormat:@"%ld",index];
    [MobClick event:@"Um_Event_VipClick" attributes:@{@"Um_Key_VipLocation":@"升级会员",@"Um_Key_UserID":uid,@"Um_Key_UserLevel":level}];
}

+ (void)buyVipFail:(NSString *)reason productId:(NSString *)productId {
    
    NSString *failReason = reason ? reason : @"未知";
    NSString *level = productId ? : @"000";
    
    NSString *uid = [UMZid getZID];
    uid = uid ? : @"user";
    
    [MobClick event:@"Um_Event_VipFailed" attributes:@{@"Um_Key_Reasons":failReason,@"Um_Key_UserID":uid,@"Um_Key_UserLevel":level}];
    NSLog(@"上报购买失败:%@", reason);
}

+ (void)buyVipSuccess:(NSString *)productId {
    
    NSString *level = productId ? : @"000";
    NSString *uid = [UMZid getZID];
    uid = uid ? : @"user";
    
    NSString *date = [KNMonitorManager getCurrentDate] ? : @"空";
    
    [MobClick event:@"Um_Event_VipSuc" attributes:@{@"Um_Key_VipType":@"xxxx",@"Um_Key_VipMoney":@(0),@"Um_Key_VipDate":date,@"Um_Key_UserID":uid,@"Um_Key_UserLevel":level}];
    
    NSLog(@"上报购买成功:%@", productId);
}

+ (NSString *)getCurrentDate {
    NSDate *currentDate = [NSDate date];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];

    NSString *formattedDateString = [dateFormatter stringFromDate:currentDate];
    
    return formattedDateString;
}

@end
