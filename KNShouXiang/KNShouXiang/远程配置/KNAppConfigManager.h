//
//  KNAppConfigManager.h
//  KNUnflodTextProject
//
//  Created by kenny on 2023/7/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KNAppConfigManager : NSObject
+ (instancetype)sharedInstance;
- (void)requestAppConfigSuccess:(void (^)(NSString *message))successHandler failure:(void (^)(NSError *error))failureHandler;
@end

NS_ASSUME_NONNULL_END
