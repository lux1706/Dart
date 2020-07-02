# Dart

Application uses [Irish Rail Realtime API](http://api.irishrail.ie/realtime/) to display info about trains.
User can search/select train stations to get list of all trains currently running - first tab `Stations`
List can be filtered by directions. 
Second tab `Trains` displays info about running trains grouped by direction.
Tapping table view row (on both screens) will open map that will be positioned to last known train location and refreshed each time train
arrives to next station.

## Dependencies

`Alamofire 5.0+`   
`SVProgressHUD`  
`XMLCoder`

##  Bootstraping

This project uses [CocoaPods](https://cocoapods.org) dependency manager. For usage and installation instructions, visit their website.
After you install `CocoaPods`, please run
```
pod install
```
from main project folder and then open `Dart.xcworkspace` with XCode.  
Project is now ready to be built.

## Implementation details

Solution is implemented using `Viper` architecture.  
Code is highly protocol oriented so that all dependencies can easyly be injected which makes it very testable.

## Future improvements/changes

- Add local notifications
- Add geofencing so that station can be automatically selected when user gets close to it.

Add unit tests for all public APIs in project.

