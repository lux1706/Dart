//
//  TrainPresenter.swift
//  Dart
//
//  Created by Tomislav Luketic on 28/06/2020.
//  Copyright (c) 2020 lux. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import SVProgressHUD
import MapKit

final class TrainPresenter {

  // MARK: - Private properties -

  private weak var view: TrainViewInterface?
  private let interactor: TrainInteractorInterface
  private let wireframe: TrainWireframeInterface
  private let info: StationAndTrainInfo
  
  private var annotations: [Station] = [] {
    didSet {
      view?.addStationAnnotations(annotations)
    }
  }
  
  var selectedTrain: ObjTrainPositions? {
    didSet {
      view?.refreshMap()
    }
  }
  
  // MARK: - Lifecycle -

  init(view: TrainViewInterface,
       interactor: TrainInteractorInterface,
       wireframe: TrainWireframeInterface,
       info: StationAndTrainInfo) {
    self.view = view
    self.interactor = interactor
    self.wireframe = wireframe
    self.info = info
    interactor.onTimer = getCurrentTrains
  }
}

// MARK: - Extensions -

extension TrainPresenter: TrainPresenterInterface {
  func viewDidLoad() {
    createStationAnotations()
  }
  
  func getCurrentTrains() {
    if info.selectedTrain != nil {
      selectedTrain = info.selectedTrain
    } else {
      interactor.getCurrentTrains { [weak self] result in
        guard
          let self = self
          else { return }
       
        SVProgressHUD.dismiss()
        switch result {
        case .success(let trainsData):
          self.selectedTrain = trainsData.first(where: { $0.TrainCode == self.info.Traincode })
        case .failure(let error):
          self.wireframe.showErrorAlert(with: error.localizedDescription)
        }
      }
    }
  }
  
  func release() {
    interactor.onTimer = nil
  }
}

private extension TrainPresenter {
  func createStationAnotations() {
    annotations = info.stations.map { station  in
      let annotation = Station(title: station.StationDesc,
                               coordinate: CLLocationCoordinate2D(latitude: station.StationLatitude,
                                                                  longitude: station.StationLongitude))
      return annotation
    }
  }
}
