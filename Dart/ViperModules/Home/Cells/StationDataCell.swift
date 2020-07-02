//
//  StationDataCell.swift
//  Dart
//
//  Created by Tomislav Luketic on 27/06/2020.
//  Copyright © 2020 lux. All rights reserved.
//

import UIKit

class StationDataCell: UITableViewCell {

  @IBOutlet weak var origDestLabel: UILabel!
  @IBOutlet weak var schArrivalLabel: UILabel!
  @IBOutlet weak var dueInLabel: UILabel!
  @IBOutlet weak var lateLabel: UILabel!
  @IBOutlet weak var lastLocationLabel: UILabel!
  @IBOutlet weak var locationLabel: UILabel!
  
  func configure(with stationData: ObjStationDataType) {
    origDestLabel.text = "\(stationData.Origin) to \(stationData.Destination)"
    schArrivalLabel.text = stationData.Scharrival
    dueInLabel.text = String(stationData.Duein)
    lateLabel.text = String(stationData.Late)
    lateLabel.textColor = stationData.Late > 0 ? UIColor.red : UIColor.black
    lastLocationLabel.text = stationData.Lastlocation
    locationLabel.text = lastLocationLabel.text == "" ? "" : "Last location:"
  }
}
