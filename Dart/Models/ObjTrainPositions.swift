//
//  ObjTrainPositions.swift
//  Dart
//
//  Created by Tomislav Luketic on 28/06/2020.
//  Copyright © 2020 lux. All rights reserved.
//

import Foundation

struct ObjTrainPositions: Decodable {
  let TrainLatitude: Double
  let TrainLongitude: Double
  let TrainCode: String
  let TrainDate: String
  let PublicMessage: String
  let Direction: String
}

struct ArrayOfObjTrainPositions: Decodable {
  let objTrainPositions: [ObjTrainPositions]
}
