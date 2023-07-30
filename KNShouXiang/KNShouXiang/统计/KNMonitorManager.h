//
//  KNMonitorManager.h
//  KNKeyboard
//
//  Created by kenny on 2023/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KNMonitorManager : NSObject

+ (void)initMonitor;

//开始页面浏览
+ (void)beginMonitorPage:(NSString *)name;

//结束页面浏览
+ (void)endMonitorPage:(NSString *)name;

//点击监控
+ (void)clickMonitor:(NSInteger)index;

//vip购买失败
+ (void)buyVipFail:(NSString *)reason productId:(NSString *)productId;

+ (void)buyVipSuccess:(NSString *)productId;

@end

NS_ASSUME_NONNULL_END
