//
//  AppDelegate.swift
//  Alert
//
//  Created by MacPro on 2022/4/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init()
        self.window?.rootViewController = UINavigationController.init(rootViewController: ViewController.init())
        self.window?.makeKeyAndVisible()
        return true
    }

}
