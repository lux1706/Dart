//
//  RailClient.swift
//  Dart
//
//  Created by Tomislav Luketic on 27/06/2020.
//  Copyright © 2020 lux. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD
import XMLCoder

enum RailClientError: Error {
  case networkError
}

typealias StationCompletionBlock = (Result<[ObjStation], RailClientError>) -> Void
typealias StationDataCompletionBlock = (Result<[ObjStationData], RailClientError>) -> Void
typealias TrainPositionsCompletionBlock = (Result<[ObjTrainPositions], RailClientError>) -> Void

protocol RailClientType {
  func getAllStations(type: String?, completion: @escaping StationCompletionBlock)
  func getStationData(by code: String, completion: @escaping StationDataCompletionBlock)
  func getCurrentTrains(type: String, completion: @escaping TrainPositionsCompletionBlock)
}

extension RailClientType {
  func getCurrentTrains(completion: @escaping TrainPositionsCompletionBlock) {
    self.getCurrentTrains(type: "A", completion: completion)
  }
}

protocol SessionProtocol {
  func request(_ convertible: URLRequestConvertible, interceptor: RequestInterceptor?) -> DataRequest
}
extension SessionProtocol {
  func request(_ convertible: URLRequestConvertible, interceptor: RequestInterceptor? = nil) -> DataRequest {
    if RailClient.displayProgress {
      SVProgressHUD.show()
    }
    return request(convertible, interceptor: interceptor)
  }
}
extension Session: SessionProtocol { }

class RailClient : RailClientType {
  static var displayProgress: Bool = true
  
  private let session: SessionProtocol
  
  init(session: SessionProtocol = AF) {
    self.session = session
  }
  
  func getAllStations(type: String?, completion: @escaping StationCompletionBlock) {
    if let type = type {
      session.request(Router.getAllStationsXML_WithStationType(stationType: type)).response { response in
           guard let data = response.data, response.error == nil else {
             completion(Result<[ObjStation], RailClientError>.failure(.networkError))
             return
           }
      
           if let stations = try? XMLDecoder().decode(ArrayOfObjStation.self, from: data) {
             completion(Result<[ObjStation], RailClientError>.success(stations.objStation))
           }
         }
    } else {
      session.request(Router.getAllStationsXML).response { response in
        guard let data = response.data, response.error == nil else {
          completion(Result<[ObjStation], RailClientError>.failure(.networkError))
          return
        }
   
        if let stations = try? XMLDecoder().decode(ArrayOfObjStation.self, from: data) {
          completion(Result<[ObjStation], RailClientError>.success(stations.objStation))
        }
      }
    }
   }
   
   func getStationData(by code: String, completion: @escaping StationDataCompletionBlock) {
    session.request(Router.getStationDataByCodeXML(stationCode: code)).response { response in
      guard let data = response.data, response.error == nil else {
        completion(Result<[ObjStationData], RailClientError>.failure(.networkError))
        return
      }
  
      if let stationsData = try? XMLDecoder().decode(ArrayOfObjStationData.self, from: data) {
        completion(Result<[ObjStationData], RailClientError>.success(stationsData.objStationData))
      }
    }
   }
  
  func getCurrentTrains(type: String, completion: @escaping TrainPositionsCompletionBlock) {
    session.request(Router.getCurrentTrainsXML_WithTrainType(trainType: type)).response { response in
      guard let data = response.data, response.error == nil else {
        completion(Result<[ObjTrainPositions], RailClientError>.failure(.networkError))
        return
      }
      
      if let trainsData = try? XMLDecoder().decode(ArrayOfObjTrainPositions.self, from: data) {
        completion(Result<[ObjTrainPositions], RailClientError>.success(trainsData.objTrainPositions))
      }
    }
  }
  
}

extension RailClientError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .networkError:
      return NSLocalizedString("Check your network connection", comment: "Network error")
    }
  }
}
