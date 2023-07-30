//
//  KNSettingViewController.m
//  KNMorseCode
//
//  Created by kenny on 2023/5/2.
//

#import "KNSettingViewController.h"
#import "KNOperationViewController.h"
#import "KNGlobalDefine.h"
#import "KNCheckUpdateManager.h"
#import "KNFeedBackViewController.h"
#import "KNPrivacyViewController.h"

#define ITUNES_URL @"https://apps.apple.com/app/id66455497057"

typedef NS_ENUM(NSInteger, SettingType) {
    SettingTypeCheckUpdate = 0,
    SettingTypeShare = 1,
    SettingTypePrivacy = 2,
    SettingTypeFeedback = 3,
};

@interface KNSettingViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation KNSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(vipStateChangeNotification) name:VIP_STATE_CHANGE_NOTIFICATION object:nil];
    // 创建UITableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = CONTROLLER_BACKGROUND_COLOR;
    [self.view addSubview:self.tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)vipStateChangeNotification {
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    } else {
        [self.tableView reloadData];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (void)removeAllSubview:(UIView *)view {
    NSArray *array = view.subviews;
    for (UIView *subview in array) {
        [subview removeFromSuperview];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellIdentifier"];
        // 添加箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.textColor = [UIColor jk_colorWithHexString:@"151515"];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor jk_colorWithHexString:@"666666"];
    }
    cell.imageView.image = nil;
    cell.textLabel.text = nil;
    cell.detailTextLabel.text = nil;
    [self removeAllSubview:cell.contentView];
    
    switch (indexPath.row) {
        case SettingTypeCheckUpdate: {
            cell.textLabel.text = @"检查更新";
            UIImage *icon = [UIImage imageNamed:@"update_normal@3x.png"];
            cell.imageView.image = icon;
            NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
            cell.detailTextLabel.text = version;
            break;
        }
        case SettingTypeShare: {
            cell.textLabel.text = @"分享";
            cell.imageView.image = [UIImage imageNamed:@"share_normal@3x.png"];
            break;
        }
        case SettingTypePrivacy: {
            cell.textLabel.text = @"隐私协议";
            cell.imageView.image = [UIImage imageNamed:@"privacy.png"];
            break;
        }
        case SettingTypeFeedback: {
            cell.textLabel.text = @"意见反馈";
            cell.imageView.image = [UIImage imageNamed:@"feedback@3x.png"];
            break;
        }
            
        default:
            break;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case SettingTypeCheckUpdate:
        {
            [KNCheckUpdateManager checkForUpdate];
            break;
        }
        case SettingTypeShare:
        {
            [self share];
            break;
        }
        case SettingTypePrivacy:
        {
            KNPrivacyViewController *controller = [[KNPrivacyViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
        case SettingTypeFeedback:
        {
            KNFeedBackViewController *controller = [[KNFeedBackViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
            break;
        }
            
        default:
            break;
    }
}

//跳转到系统键盘设置
- (void)jumpToSettings {
    NSURL *settingsUrl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:settingsUrl]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:settingsUrl options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:settingsUrl options:@{} completionHandler:^(BOOL success) {
                
            }];
        }
    }
}

- (void)share {
    NSArray *activityItems = @[ITUNES_URL];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityViewController.title = @"AI工具大全";
    [self presentViewController:activityViewController animated:YES completion:nil];
}

@end
