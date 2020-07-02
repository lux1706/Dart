//
//  CustomSegmentedControl.swift
//  Dart
//
//  Created by Tomislav Luketic on 01/07/2020.
//  Copyright © 2020 lux. All rights reserved.
//

import Foundation
import UIKit

class CustomSegmentedControl: UISegmentedControl {
  override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
