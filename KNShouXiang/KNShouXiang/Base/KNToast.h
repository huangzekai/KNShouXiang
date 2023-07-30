//
//  KNToast.h
//  KNMorseCode
//
//  Created by kenny on 2023/5/4.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KNToast : NSObject

+ (void)showLoadingToast:(UIView *)view;

+ (void)showLoadingWithText:(NSString *)text inView:(UIView *)view;

+ (void)hideLoadingView;

+ (void)showSuccessToastWithText:(NSString *)text;

+ (void)showSuccessToastWithText:(NSString *)text dismissAfterDelay:(NSInteger)delay;

+ (void)showFailToastWithText:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
