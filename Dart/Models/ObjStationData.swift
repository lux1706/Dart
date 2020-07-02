//
//  ObjStationData.swift
//  Dart
//
//  Created by Tomislav Luketic on 27/06/2020.
//  Copyright © 2020 lux. All rights reserved.
//

import Foundation

protocol ObjStationDataType {
  var Origin: String { get }
  var Destination: String { get }
  var Scharrival: String { get }
  var Duein: Int { get }
  var Late: Int { get }
  var Lastlocation: String { get }
}

struct ObjStationData: Decodable {
  let Servertime: String
  let Traincode: String
  let Stationfullname: String
  let Stationcode: String
  let Querytime: String
  let Traindate: String
  let Origin: String
  let Destination: String
  let Status: String
  let Lastlocation: String
  let Schdepart: String
  let Expdepart: String
  let Scharrival: String
  let Exparrival: String
  let Traintype: String
  let Locationtype: String
  let Direction: String
  let Duein: Int
  let Late: Int
}

extension ObjStationData: ObjStationDataType { }

struct ArrayOfObjStationData: Decodable {
  let objStationData: [ObjStationData]
}
