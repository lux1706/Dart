//
//  Station.swift
//  Dart
//
//  Created by Tomislav Luketic on 29/06/2020.
//  Copyright © 2020 lux. All rights reserved.
//

import Foundation
import MapKit

class Station: NSObject, MKAnnotation {
  let title: String?
  let subtitle: String?
  let coordinate: CLLocationCoordinate2D

  init(
    title: String?,
    subtitle: String? = "Train Station",
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.subtitle = subtitle
    self.coordinate = coordinate

    super.init()
  }
}

extension Station {
  var image: UIImage {
    return UIImage(named: "Flag")!
  }
}
