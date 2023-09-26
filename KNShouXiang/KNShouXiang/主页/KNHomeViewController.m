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
#define BUTTON_SPACE 15
#define BOTTOM_SPACE 60

@interface KNHomeViewController ()
@property (nonatomic, assign) NSInteger count;
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

- (BOOL)isBeforeDay {
    // 创建一个表示2023年9月30日的NSDate对象
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.year = 2023;
    dateComponents.month = 10;
    dateComponents.day = 5;

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *targetDate = [calendar dateFromComponents:dateComponents];

    // 获取当前日期
    NSDate *currentDate = [NSDate date];

    // 比较当前日期和目标日期
    if ([currentDate compare:targetDate] == NSOrderedDescending) {
        NSLog(@"当前日期大于2023年10月5日");
        return NO;
    } else {
        NSLog(@"当前日期小于或等于2023年10月5日");
        return YES;
    }
}

- (void)addAllSubview {

    BOOL isBeforeDay = [self isBeforeDay];
    NSArray *titleArray = @[@"如何看手相", @"初识手相", @"八大掌丘", @"手掌八宫", @"六大线纹", @"观手知健康"];
    NSArray *imageArray = @[@"shouxiangjiaocheng", @"jibenshouxiang", @"badazhangqiu", @"shouzhangbagong", @"liudaxianwen", @"shouxiangjiankang"];
    if (isBeforeDay) {
        titleArray = @[@"如何看手相", @"八大掌丘", @"手掌八宫", @"六大线纹", @"观手知健康"];
        imageArray = @[@"shouxiangjiaocheng", @"badazhangqiu", @"shouzhangbagong", @"liudaxianwen", @"shouxiangjiankang"];
    }
    self.count = titleArray.count;

    CGFloat width = self.view.bounds.size.width - BOTTOM_SPACE;
    CGFloat y = 30;
    CGFloat height = (self.view.jk_height - 20 - BOTTOM_SPACE - BUTTON_SPACE * 5) / titleArray.count;
    
    for (NSInteger index = 0; index < titleArray.count ; index ++) {
        KNShouXiangButton *button = [[KNShouXiangButton alloc] initWithFrame:CGRectMake(30, y, width, height)];
        [button setTitle:titleArray[index] forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:imageArray[index]];
        [button setImage:image forState:UIControlStateNormal];
        [button setImage:image forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + index;
        [self.view addSubview:button];
        y += (height + BUTTON_SPACE);
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat y = 30;
    CGFloat width = self.view.bounds.size.width - BOTTOM_SPACE;
    CGFloat height = (self.view.jk_height - 20 - BOTTOM_SPACE - BUTTON_SPACE * 5) / self.count;
    for (NSInteger index = 0; index < self.count ; index ++) {
        UIButton *button = [self.view viewWithTag:100 + index];
        button.frame = CGRectMake(30, y, width, height);
        y += (height + BUTTON_SPACE);
    }
}

- (void)buttonAction:(UIButton *)sender {
    
    if ([self isBeforeDay]) {
        switch (sender.tag - 100) {
            case 0: {
                KNAboutShouXiangViewController *ctr = [[KNAboutShouXiangViewController alloc] init];
                [self.navigationController pushViewController:ctr animated:YES];
                break;
            }
            case 1: {
                KNZhangQiuViewController *ctr = [[KNZhangQiuViewController alloc] init];
                [self.navigationController pushViewController:ctr animated:YES];
                break;
            }
            case 2: {
                KNZhangGongViewController *ctr = [[KNZhangGongViewController alloc] init];
                [self.navigationController pushViewController:ctr animated:YES];
                break;
            }
            case 3: {
                KNXianWenViewController *ctr = [[KNXianWenViewController alloc] init];
                [self.navigationController pushViewController:ctr animated:YES];
                break;
            }
            case 4: {
                KNJianKangViewController *ctr = [[KNJianKangViewController alloc] init];
                [self.navigationController pushViewController:ctr animated:YES];
                break;
            }
                
            default:
                break;
        }
    } else {
        switch (sender.tag - 100) {
            case 0: {
                KNAboutShouXiangViewController *ctr = [[KNAboutShouXiangViewController alloc] init];
                [self.navigationController pushViewController:ctr animated:YES];
                break;
            }
            case 1: {
                KNJiBenShouXiangController *ctr = [[KNJiBenShouXiangController alloc] init];
                [self.navigationController pushViewController:ctr animated:YES];
                break;
            }
            case 2: {
                KNZhangQiuViewController *ctr = [[KNZhangQiuViewController alloc] init];
                [self.navigationController pushViewController:ctr animated:YES];
                break;
            }
            case 3: {
                KNZhangGongViewController *ctr = [[KNZhangGongViewController alloc] init];
                [self.navigationController pushViewController:ctr animated:YES];
                break;
            }
            case 4: {
                KNXianWenViewController *ctr = [[KNXianWenViewController alloc] init];
                [self.navigationController pushViewController:ctr animated:YES];
                break;
            }
            case 5: {
                KNJianKangViewController *ctr = [[KNJianKangViewController alloc] init];
                [self.navigationController pushViewController:ctr animated:YES];
                break;
            }
                
            default:
                break;
        }
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
