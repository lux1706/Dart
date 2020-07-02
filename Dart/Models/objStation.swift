//
//  Station.swift
//  Dart
//
//  Created by Tomislav Luketic on 27/06/2020.
//  Copyright © 2020 lux. All rights reserved.
//

import Foundation

struct ObjStation: Decodable {
  let StationDesc: String
  let StationAlias: String?
  let StationLatitude: Double
  let StationLongitude: Double
  let StationCode: String
  let StationId: String
}

struct ArrayOfObjStation: Decodable {
  let objStation: [ObjStation]
}

enum StationType: String, CaseIterable {
  case all
  case mainline
  case suburban
  case dart
}
