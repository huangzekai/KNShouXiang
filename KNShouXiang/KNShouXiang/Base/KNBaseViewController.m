//
//  KNBaseViewController.m
//  KNMorseCode
//
//  Created by kenny on 2023/5/2.
//

#import "KNBaseViewController.h"
#import "KNGlobalDefine.h"
#import "KNMonitorManager.h"

@interface KNBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation KNBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = CONTROLLER_BACKGROUND_COLOR;
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //解决导航栏pushviewcontroller闪烁的问题 https://blog.csdn.net/m0_37815556/article/details/123049308
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [UINavigationBarAppearance new];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = self.navigationController.navigationBar.standardAppearance;
    }
    [KNMonitorManager beginMonitorPage:self.title];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [KNMonitorManager endMonitorPage:self.title];
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 如果导航控制器中有多个视图控制器，则启用侧滑手势
    return self.navigationController.viewControllers.count > 1;
}

- (void)addRightBarButtonWithTitle:(NSString *)title {
    if (title.length <= 0) {
        return;
    }
    // 创建右上角按钮
     UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:title
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(rightBarButtonAction:)];
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    [rightBarButton setTitleTextAttributes:attributes forState:UIControlStateNormal];
     // 将按钮添加到 navigationItem 的 rightBarButtonItem 属性
     self.navigationItem.rightBarButtonItem = rightBarButton;
}

- (void)rightBarButtonAction:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
