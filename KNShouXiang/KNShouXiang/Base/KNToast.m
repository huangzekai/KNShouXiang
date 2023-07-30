//
//  KNToast.m
//  KNMorseCode
//
//  Created by kenny on 2023/5/4.
//

#import "KNToast.h"
#import "UIColor+JKHEX.h"
#import "JDStatusBarNotificationPresenter.h"
#import "MBProgressHUD.h"

@interface KNToast ()
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation KNToast

+ (instancetype)sharedInstance {
    static KNToast *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[KNToast alloc] init];
    });
    return sharedInstance;
}

+ (void)showLoadingWithText:(NSString *)text inView:(UIView *)view {
    // 在当前视图控制器的view上显示loading图
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    // 设置loading图的样式（可选）
    hud.mode = MBProgressHUDModeIndeterminate;

    // 设置loading图的标题（可选）
    hud.label.text = text;

    // 设置loading图的详细描述（可选）
    hud.detailsLabel.text = @"请耐心等待";
    
    [KNToast sharedInstance].hud = hud;

    // 设置loading图的样式（可选）
    hud.mode = MBProgressHUDModeIndeterminate;
}

+ (void)showLoadingToast:(UIView *)view {
    // 在当前视图控制器的view上显示loading图
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    [KNToast sharedInstance].hud = hud;
    
    // 设置loading图的详细描述（可选）
    hud.detailsLabel.text = @"正在刷新";
    
    // 设置loading图的样式（可选）
    hud.mode = MBProgressHUDModeIndeterminate;
}

+ (void)hideLoadingView {
    [[KNToast sharedInstance].hud hideAnimated:YES];
}

+ (void)showSuccessToastWithText:(NSString *)text {
    [KNToast showSuccessToastWithText:text dismissAfterDelay:2];
}

+ (void)showSuccessToastWithText:(NSString *)text dismissAfterDelay:(NSInteger)delay {
    if (text.length <= 0) {
        return;
    }
    UIImage *image = [UIImage imageNamed:@"success@3x.png"];
    [KNToast showToastWithImage:image text:text];
}


+ (void)showFailToastWithText:(NSString *)text {
    if (text.length <= 0) {
        return;
    }
    UIImage *image = [UIImage imageNamed:@"error@3x.png"];
    [KNToast showToastWithImage:image text:text];
}

+ (void)showToastWithImage:(UIImage *)image text:(NSString *)text {
    
    [[JDStatusBarNotificationPresenter sharedPresenter] updateDefaultStyle:^JDStatusBarNotificationStyle * _Nonnull(JDStatusBarNotificationStyle * _Nonnull style) {
        style.backgroundStyle.backgroundColor = [UIColor jk_colorWithWholeRed:0 green:0 blue:0 alpha:0.6];
        style.textStyle.textColor = [UIColor whiteColor];
        return style;
    }];
    
    [[JDStatusBarNotificationPresenter sharedPresenter] presentWithText:text dismissAfterDelay:2];
    if (image) {
        UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
        [[JDStatusBarNotificationPresenter sharedPresenter] displayLeftView:imageview];
    }
}

@end
