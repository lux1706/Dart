//
//  Router.swift
//  Dart
//
//  Created by Tomislav Luketic on 27/06/2020.
//  Copyright © 2020 lux. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
  case getAllStationsXML
  case getAllStationsXML_WithStationType(stationType: String)
  
  case getCurrentTrainsXML
  case getCurrentTrainsXML_WithTrainType(trainType: String = "D")
  
  case getStationDataByNameXML(stationDesc: String)
  case getStationDataByNameXML2(stationDesc: String, numMins: Int)
  case getStationDataByCodeXML(stationCode: String)
  case getStationDataByCodeXML_WithNumMins(stationCode: String, numMins: Int)
  case getStationsFilterXML(stationText: String)
  
  case getTrainMovementsXML(trainId: String, trainDate: String) //21 dec 2011
}

extension Router {
  private static let baseURLPath = "http://api.irishrail.ie/realtime/realtime.asmx"
  
  private var method: HTTPMethod {
    switch self {
    default:
      return .get
   }
  }
  
  private var path: String {
    switch self {
    case .getAllStationsXML:
      return "/getAllStationsXML"
    case .getAllStationsXML_WithStationType:
      return "/getAllStationsXML_WithStationType"
    case .getCurrentTrainsXML:
      return "/getCurrentTrainsXML"
    case .getCurrentTrainsXML_WithTrainType:
      return "/getCurrentTrainsXML_WithTrainType"
    case .getStationDataByNameXML, .getStationDataByNameXML2:
      return "/getStationDataByNameXML"
    case .getStationDataByCodeXML:
      return "/getStationDataByCodeXML"
    case .getStationDataByCodeXML_WithNumMins:
      return "/getStationDataByCodeXML_WithNumMins"
    case .getStationsFilterXML:
      return "/getStationsFilterXML"
    case .getTrainMovementsXML:
      return "/getTrainMovementsXML"

    }
  }

  private var parameters: [String: Any] {
    var params: [String: Any] = [:]
    
    switch self {
    case .getAllStationsXML_WithStationType(let stationType):
      params["StationType"] = stationType
    case .getCurrentTrainsXML_WithTrainType(let trainType):
      params["TrainType"] = trainType
    case .getStationDataByNameXML(let stationDesc):
      params["StationDesc"] = stationDesc
    case .getStationDataByNameXML2(let stationDesc, let numMins):
      params["StationDesc"] = stationDesc
      params["NumMins"] = numMins
    case .getStationDataByCodeXML(let stationCode):
      params["StationCode"] = stationCode
    case .getStationDataByCodeXML_WithNumMins(let stationCode, let numMins):
      params["StationCode"] = stationCode
      params["NumMins"] = numMins
    case .getStationsFilterXML(let stationText):
      params["StationText"] = stationText
    case .getTrainMovementsXML(let trainId, let trainDate):
      params["TrainId"] = trainId
      params["TrainDate"] = trainDate
    default:
      break
    }
    
    return params
  }
  
  func asURLRequest() throws -> URLRequest {
    let url = try Router.baseURLPath.asURL()
    var request = URLRequest(url: url.appendingPathComponent(path))
    request.httpMethod = method.rawValue
    return try URLEncoding.default.encode(request, with: parameters)
  }
}
