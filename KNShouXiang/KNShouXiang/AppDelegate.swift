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
        
        
        let mainTabBarVc = KNNavigationController(rootViewController: KNHomeViewController())
        
        self.window = UIWindow()
        self.window?.frame  = UIScreen.main.bounds
        self.window?.rootViewController = mainTabBarVc
        self.window?.makeKeyAndVisible()
        self.window?.overrideUserInterfaceStyle = .light
        
        setDefaultAppearance()

        Bugly.start(withAppId: "a2cd2e37d8")

        
        return true
    }
    func setDefaultAppearance() {
        let titleFont = UIFont.boldSystemFont(ofSize: 24) // 设置字体大小为 24
        let appearance = UINavigationBar.appearance()
        appearance.titleTextAttributes = [NSAttributedString.Key.font: titleFont]
    }

}

