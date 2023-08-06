//
//  KNGlobalDefine.h
//  KNMorseCode
//
//  Created by kenny on 2023/4/30.
//

#import <JKCategories/UIColor+JKHEX.h>

#ifndef KNGlobalDefine_h
#define KNGlobalDefine_h

#define APPLE_ID @"6458547178"
#define ITUNES_URL  [NSString stringWithFormat:@"https://apps.apple.com/app/id%@", APPLE_ID]

#define VIP_STATE_CHANGE_NOTIFICATION @"vipStateChangeNotification"

//按钮默认颜色
#define BUTTON_NORMAL_COLOR [UIColor jk_colorWithWholeRed:20 green:20 blue:20]
//选中颜色
#define BUTTON_SELECT_COLOR [UIColor jk_colorWithWholeRed:74 green:180 blue:89]
//Tabbar背景颜色
#define TABBAR_BACKGROUND_COLOR [UIColor jk_colorWithWholeRed:244 green:244 blue:244]
//viewcontroller背景颜色
#define CONTROLLER_BACKGROUND_COLOR [UIColor jk_colorWithWholeRed:232 green:232 blue:232]
///灰色
#define GRAY_COLOR [UIColor jk_colorWithHexString:@"#666666"]
///黑色
#define BLACK_COLOR [UIColor jk_colorWithHexString:@"#333333"]

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height



#endif /* KNGlobalDefine_h */
