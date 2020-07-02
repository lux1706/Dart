//
//  AppDelegate.swift
//  Dart
//
//  Created by Tomislav Luketic on 27/06/2020.
//  Copyright © 2020 lux. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    displayHomePage()
    return true
  }
  
  private func displayHomePage() {
    let initialController = MainTabBar()
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window?.rootViewController = initialController
    self.window?.makeKeyAndVisible()
  }
}

