//
//  MainTabBar.swift
//  Dart
//
//  Created by Tomislav Luketic on 27/06/2020.
//  Copyright © 2020 lux. All rights reserved.
//

import Foundation
import UIKit

class MainTabBar: UITabBarController {
  private let client: RailClientType
  
  init(client: RailClientType = RailClient()){
    self.client = client
    super.init(nibName: nil, bundle: nil)
    addViewControllers()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func addViewControllers() {
    viewControllers = [HomeWireframe(client: client), TrainsWireframe(client: client)].map{ UINavigationController(rootViewController: $0.viewController) }
  }
}
