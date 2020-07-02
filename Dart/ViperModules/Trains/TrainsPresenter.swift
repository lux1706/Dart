//
//  TrainsPresenter.swift
//  Dart
//
//  Created by Tomislav Luketic on 30/06/2020.
//  Copyright (c) 2020 lux. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import SVProgressHUD

final class TrainsPresenter {

  // MARK: - Private properties -

  private unowned let view: TrainsViewInterface
  private let interactor: TrainsInteractorInterface
  private let wireframe: TrainsWireframeInterface
  private var direction: String?
  private var directions: [String] = []
  private var selectedTrain: ObjTrainPositions?
  private var stations: [ObjStation] = []
  
  private var trains: [(direction: String, trains: [ObjTrainPositions])] = [] {
    didSet {
      filteredTrains = trains
    }
  }
  
  var filteredTrains: [(direction: String, trains: [ObjTrainPositions])] = [] {
    didSet {
      view.refreshTrains()
    }
  }

  // MARK: - Lifecycle -

  init(view: TrainsViewInterface, interactor: TrainsInteractorInterface, wireframe: TrainsWireframeInterface) {
      self.view = view
      self.interactor = interactor
      self.wireframe = wireframe
  }
}

// MARK: - Extensions -

extension TrainsPresenter: TrainsPresenterInterface {
  func getCurrentTrains() {
    interactor.getCurrentTrains { [weak self] result in
      guard
        let self = self
        else { return }
     
      SVProgressHUD.dismiss()
      switch result {
      case .success(let trainsData):
        self.trains = Dictionary(grouping: trainsData, by: { $0.Direction })
          .map { direction, data in return (direction: direction, trains: data) }.sorted(by: { $0.direction < $1.direction })
        self.manageDirections()
      case .failure(let error):
        self.trains = []
        self.wireframe.showErrorAlert(with: error.localizedDescription)
      }
    }
  }
  
  func getAllStations(type: String?) {
    interactor.getAllStations(type: type) { [unowned self] result in
      SVProgressHUD.dismiss()
      switch result {
      case .success(let stations):
        self.stations = stations
        self.gotoTrains()
      case .failure(let error):
        self.stations = []
        self.wireframe.showErrorAlert(with: error.localizedDescription)
      }
    }
  }
  
  func directionChanged(index: Int) {
    guard
      let direction = directions[safe: index]
      else { return }
    
    self.direction = direction
    filteredTrains = index == 0 ? trains : filterTrainsData(by: direction)
  }
  
  func trainSelected(at indexPath: IndexPath) {
    let data = trains[indexPath.section]
    selectedTrain = data.trains[indexPath.row]
    if stations.count == 0 {
      getAllStations(type: nil)
    } else {
      gotoTrains()
    }
  }
}

private extension TrainsPresenter {
  func gotoTrains() {
    if let train = selectedTrain {
      let info = StationAndTrainInfo(Traincode: train.TrainCode,
                                        stations: stations,
                                        selectedTrain: train)
      wireframe.navigate(to: .trainMap(info: info, client: interactor.client))
    }
  }
  
  func filterTrainsData(by direction: String) -> [(direction: String, trains: [ObjTrainPositions])] {
    return trains.filter { $0.direction == direction }
  }
  
  func manageDirections() {
    var directions = directionsForTrainsData
    if directions.count > 1 {
       directions.insert("All", at: 0)
    }
    directions.sort()
    if directions != self.directions {
      self.direction = directions.first
      view.trainsDataChanged(containing: directions)
    }
    self.directions = directions
  }
  
  var directionsForTrainsData: [String] {
    let directions = trains.map { $0.direction }
    return directions
  }
}
