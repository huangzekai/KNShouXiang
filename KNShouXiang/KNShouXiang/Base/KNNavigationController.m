//
//  KNNavigationController.m
//  KNMorseCode
//
//  Created by kenny on 2023/5/4.
//

#import "KNNavigationController.h"
#import <JKCategories/UIColor+JKHEX.h>

@interface KNNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation KNNavigationController

- (instancetype)init {
    self = [super init];
    if (self) {
        self.navigationBar.tintColor = [UIColor jk_colorWithHexString:@"151515"];
        UIFont *font = [UIFont boldSystemFontOfSize:20];
        NSDictionary *attributes = @{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor jk_colorWithHexString:@"151515"]};
        [self.navigationBar setTitleTextAttributes:attributes];
        [self.navigationBar setBarTintColor:[UIColor whiteColor]];
        self.navigationBar.translucent = NO;
        self.interactivePopGestureRecognizer.enabled = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray *controllerArray = navigationController.viewControllers;
    if (controllerArray.count > 0) {
        UIViewController *root = [navigationController.viewControllers objectAtIndex:0];
        if (root != viewController) {
            UIImage *image = [UIImage imageNamed:@"back_icon.png"];
            UIImage *backImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            UIBarButtonItem *itemleft = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStylePlain target:self action:@selector(backBarAction)];
            viewController.navigationItem.leftBarButtonItem = itemleft;
        }
    }
}


- (void)backBarAction {
    [self popViewControllerAnimated:YES];
}


@end
