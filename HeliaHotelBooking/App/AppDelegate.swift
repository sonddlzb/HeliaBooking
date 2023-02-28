//
//  AppDelegate.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 28/02/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = BaseNavigationController(rootViewController: RootViewController())
        window?.rootViewController = navigationController // Your initial view controller.
        window?.makeKeyAndVisible()
        return true
    }

}
