//
//  KNHomeViewController.m
//  KNUnflodTextProject
//
//  Created by kennykhuang on 2023/7/2.
//

#import "KNHomeViewController.h"
#import "KNGlobalDefine.h"
#import "KNMonitorManager.h"
#import "KNAppConfigManager.h"
#import "UIView+JKFrame.h"
#import <StoreKit/StoreKit.h>
#import "KNSettingViewController.h"
#import "KNShouXiang-Swift.h"
#import "KNShouXiangButton.h"
#import "Reachability.h"
#import "KNToast.h"

#define BUTTON_HEIGH 100

@interface KNHomeViewController ()

@end

@implementation KNHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"手相图解";
    
    [self addRightbarButton];
    
    [self addAllSubview];
    
    [self checkAndShowAppReviewDialog];
    
    [self checkAppConfig];
}

- (void)addAllSubview {
    
    NSArray *titleArray = @[@"如何看手相", @"基本手相", @"八大掌丘", @"手掌八宫", @"六大线纹"];
    NSArray *imageArray = @[@"bagong", @"bagong",@"zhangqiu", @"bagong", @"bagong"];
    CGFloat width = self.view.bounds.size.width - 60;
    CGFloat y = 30;
    CGFloat height = (self.view.jk_height - 30 - 60 - 20 * 4) / 5;
    
    for (NSInteger index = 0; index < 5 ; index ++) {
        KNShouXiangButton *button = [[KNShouXiangButton alloc] initWithFrame:CGRectMake(30, y, width, height)];
        [button setImage:[UIImage imageNamed:imageArray[index]] forState:UIControlStateNormal];
        [button setTitle:titleArray[index] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + index;
        [self.view addSubview:button];
        y += (height + 20);
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat y = 30;
    CGFloat width = self.view.bounds.size.width - 60;
    CGFloat height = (self.view.jk_height - 30 - 60 - 20 * 4) / 5;
    for (NSInteger index = 0; index < 5 ; index ++) {
        UIButton *button = [self.view viewWithTag:100 + index];
        button.frame = CGRectMake(30, y, width, height);
        y += (height + 20);
    }
}

- (void)buttonAction:(UIButton *)sender {
    
    switch (sender.tag - 100) {
        case 0: {
            KNAboutShouXiangViewController *ctr = [[KNAboutShouXiangViewController alloc] init];
            [self.navigationController pushViewController:ctr animated:YES];
            break;
        }
        case 2: {
            KNZhangQiuViewController *ctr = [[KNZhangQiuViewController alloc] init];
            [self.navigationController pushViewController:ctr animated:YES];
        }
            
        default:
            break;
    }

}

- (void)addRightbarButton {
    UIImage *image = [UIImage imageNamed:@"setting_select.png"];
    UIImage *backImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    self.navigationItem.rightBarButtonItem = refreshButton;
}

- (void)rightBarAction {
    KNSettingViewController *ctr = [[KNSettingViewController alloc] init];
    [self.navigationController pushViewController:ctr animated:YES];
}

- (void)checkAppConfig {
    __weak __typeof(self) weakSelf = self;

    [[KNAppConfigManager sharedInstance] requestAppConfigSuccess:^(NSString * _Nonnull message) {
        
        if (message.length > 0) {
            [weakSelf showAlertWithTitle:@"提示" message:message];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)checkAndShowAppReviewDialog {
    // 获取用户的首次启动日期
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *firstLaunchDate = [defaults objectForKey:@"FirstLaunchDate"];

    if (!firstLaunchDate) {
        // 如果首次启动日期不存在，将当前时间存储为首次启动日期，并返回
        [defaults setObject:[NSDate date] forKey:@"FirstLaunchDate"];
        [defaults synchronize];
        return;
    }

    // 获取距离现在的天数
    NSInteger daysSinceFirstLaunch = [self daysBetweenDate:firstLaunchDate andDate:[NSDate date]];

    // 检查是否已安装1天以上
    if (daysSinceFirstLaunch >= 1) {
        // 获取上次弹窗的日期
        NSDate *lastReviewRequestDate = [defaults objectForKey:@"LastReviewRequestDate"];

        // 如果上次弹窗未记录或者超过了1天，则尝试弹出评价框
        if (!lastReviewRequestDate || [self daysBetweenDate:lastReviewRequestDate andDate:[NSDate date]] > 1) {
            // 更新 LastReviewRequestDate（上次请求的时间）
            [defaults setObject:[NSDate date] forKey:@"LastReviewRequestDate"];
            [defaults synchronize];

            // 显示评价弹框
            [SKStoreReviewController requestReview];
        }
    }
}


// 用于计算两个日期之间相差天数的函数
- (NSInteger)daysBetweenDate:(NSDate *)fromDateTime andDate:(NSDate *)toDateTime {
    NSDate *fromDate;
    NSDate *toDate;

    NSCalendar *calendar = [NSCalendar currentCalendar];

    [calendar rangeOfUnit:NSCalendarUnitDay
                startDate:&fromDate
                 interval:NULL
                  forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay
                startDate:&toDate
                 interval:NULL
                  forDate:toDateTime];

    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate
                                                 toDate:toDate
                                                options:0];

    return [difference day];
}


@end
