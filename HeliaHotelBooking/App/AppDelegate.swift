//
//  AppDelegate.swift
//  HeliaHotelBooking
//
//  Created by đào sơn on 28/02/2023.
//

import UIKit
import FirebaseCore
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = BaseNavigationController(rootViewController: RootViewController())
        window?.rootViewController = navigationController // Your initial view controller.
        window?.makeKeyAndVisible()

        self.config()
        return true
    }

    func config() {
        self.configFirebase()
    }

    func configFirebase() {
        FirebaseApp.configure()
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }

}
