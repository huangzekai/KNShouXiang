//
//  KNMainTabbarController.m
//  KNMorseCode
//
//  Created by kenny on 2023/4/30.
//

#import "KNMainTabbarController.h"
#import <JKCategories/UIColor+JKHEX.h>
#import "KNSettingViewController.h"
#import <JKCategories/UINavigationBar+JKAwesome.h>
#import "KNHomeViewController.h"
#import "KNNavigationController.h"
#import "KNGlobalDefine.h"

@interface KNMainTabbarController ()

@end

@implementation KNMainTabbarController

- (void)setTabbarAppear {
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = GRAY_COLOR;
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];
      
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = BUTTON_SELECT_COLOR;
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:11];

    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    self.tabBar.backgroundColor = TABBAR_BACKGROUND_COLOR;
    self.tabBar.barTintColor = [UIColor whiteColor]; // 将背景颜色设置为白色
    self.tabBar.tintColor = TABBAR_BACKGROUND_COLOR; // 将图片颜色设置为黑色
    
    self.tabBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewControllers];
    [self setTabbarAppear];
}

- (KNNavigationController *)createTabControllerWithClass:(Class)class {
    UIViewController *controller = [[class alloc] init];
    KNNavigationController *navigationController = [[KNNavigationController alloc] initWithRootViewController:controller];

    return navigationController;
}

- (void)setupViewControllers {
    // 创建视图控制器
    UIViewController *firstVC = [self createTabControllerWithClass:[KNHomeViewController class]];
    UIViewController *thridVC = [self createTabControllerWithClass:[KNSettingViewController class]];

    UIImage *firstNormalImage = [self createImageWithName:@"all_normal@3x.png"];
    UIImage *firstSelectImage = [self createImageWithName:@"all_selected@3x.png"];

    UIImage *thridNormalImage = [self createImageWithName:@"setting_normal@3x.png"];
    UIImage *thridSelectImage = [self createImageWithName:@"setting_select@3x.png"];
    
    // 为视图控制器设置标题和图像
    firstVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"AI工具集" image:firstNormalImage selectedImage:firstSelectImage];
    thridVC.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:thridNormalImage selectedImage:thridSelectImage];

    // 将视图控制器添加到标签栏控制器
    self.viewControllers = @[firstVC, thridVC];
}

- (UIImage *)createImageWithName:(NSString *)name {
    UIImage *originalImage = [UIImage imageNamed:name];
    UIImage *image = [originalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}

@end
