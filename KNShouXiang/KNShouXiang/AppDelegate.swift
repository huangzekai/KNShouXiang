//
//  AppDelegate.swift
//  KNToolsSet
//
//  Created by kenny on 2023/7/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setDefaultAppearance()
        
        let mainTabBarVc = KNNavigationController(rootViewController: KNHomeViewController())
        
        self.window = UIWindow()
        self.window?.frame  = UIScreen.main.bounds
        self.window?.rootViewController = mainTabBarVc
        self.window?.makeKeyAndVisible()
        self.window?.overrideUserInterfaceStyle = .light
        
        Bugly.start(withAppId: "a2cd2e37d8")

        
        return true
    }
    func setDefaultAppearance() {
        //tabbar背景色
        UITabBar.appearance().backgroundColor = UIColor.white
        //tabbar字体颜色
        UITabBar.appearance().tintColor = UIColor.white
        UITabBar.appearance().barTintColor = UIColor.white
        
        // 设置正常状态下的字体大小和颜色
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12),
                                                          .foregroundColor: UIColor.black], for: .normal)

        // 设置选中状态下的字体大小和颜色
        UITabBarItem.appearance().setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 12),
                                                          .foregroundColor: redColor], for: .selected)
    }

}

