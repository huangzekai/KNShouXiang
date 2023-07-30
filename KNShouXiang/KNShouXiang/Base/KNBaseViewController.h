//
//  KNBaseViewController.h
//  KNMorseCode
//
//  Created by kenny on 2023/5/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KNBaseViewController : UIViewController
//添加右上角按钮
- (void)addRightBarButtonWithTitle:(NSString *)title;
//点击右上角按钮
- (void)rightBarButtonAction:(id)sender;
@end

NS_ASSUME_NONNULL_END
