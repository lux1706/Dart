//
//  TrainViewController.swift
//  Dart
//
//  Created by Tomislav Luketic on 28/06/2020.
//  Copyright (c) 2020 lux. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import MapKit

final class TrainViewController: UIViewController {

    // MARK: - Public properties -
  @IBOutlet weak var messageLabel: UILabel!
  
  @IBOutlet weak var mapView: MKMapView!
  var presenter: TrainPresenterInterface!

  // MARK: - Lifecycle -

  override func viewDidLoad() {
    super.viewDidLoad()
    presenter.viewDidLoad()
    setupView()
    presenter.getCurrentTrains()
  }
  
  private func setupView() {
    mapView.register(StationMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
  }
  
  deinit {
    presenter.release()
  }
	
}

// MARK: - Extensions -

extension TrainViewController: TrainViewInterface {
  
  func addStationAnnotations(_ stations: [Station]) {
    mapView.addAnnotations(stations)
  }
  
  func refreshMap() {
    if let train = presenter.selectedTrain {
      mapView.centerToLocation(CLLocation(latitude: train.TrainLatitude,
                                          longitude: train.TrainLongitude))
      messageLabel.text = train.PublicMessage.replacingOccurrences(of: "\\n", with: " ")
    } else {
      messageLabel.text = "< No information >"
    }
  }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 1000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
