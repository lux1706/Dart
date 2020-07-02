//
//  StationMarkerView.swift
//  Dart
//
//  Created by Tomislav Luketic on 29/06/2020.
//  Copyright © 2020 lux. All rights reserved.
//

import Foundation
import MapKit

class StationMarkerView: MKAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      guard
        let station = newValue as? Station
        else { return }
      image = station.image
    }
  }
}

