//
//  KNCheckUpdateManager.h
//  KNMorseCode
//
//  Created by kenny on 2023/5/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KNCheckUpdateManager : NSObject

//检查更新
//注意：不能发请求到appstore查看是否是最新版本，不然会被苹果拒绝
+ (void)checkForUpdate;

@end

NS_ASSUME_NONNULL_END
