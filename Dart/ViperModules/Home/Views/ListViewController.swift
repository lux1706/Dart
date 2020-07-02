//
//  ListViewController.swift
//  Dart
//
//  Created by Tomislav Luketic on 27/06/2020.
//  Copyright © 2020 lux. All rights reserved.
//

import Foundation
import UIKit


class ListViewController: UITableViewController {
  
  var presenter: HomePresenterInterface!
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return presenter.filteredStations.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard
         let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell") as? ListItemCell
         else { preconditionFailure("Can't dequeue cell with `ListItemCell` identifier") }
    
    let station = presenter.filteredStations[indexPath.row]
    cell.nameLabel.text = station.StationDesc
    return cell
  }
  
}
