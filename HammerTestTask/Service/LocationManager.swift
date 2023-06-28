//
//  LocationManager.swift
//  MVP+Unit
//
//  Created by Alex Shtandaruk on 8.05.2023.
//

//import MapKit
//import UIKit
//import CoreLocation
//
//class LocationManager: UIViewController {
//
//    let locationManager = CLLocationManager()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//    }
//
//    func checkLocationEnabled() {
//        if CLLocationManager.locationServicesEnabled() {
//            locationManager.delegate = self
//            locationManager.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager.startUpdatingLocation()
//        } else {
//            print("no location")
//            let alert = UIAlertController(
//                title: "Alert",
//                message: "Turn on location service",
//                preferredStyle: .actionSheet
//            )
//            let settingAction = UIAlertAction(
//                title: "Setting",
//                style: .default
//            ) { alert in
//                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
//            }
//            let cancelAction = UIAlertAction(
//                title: "Cancel",
//                style: .cancel)
//            alert.addAction(settingAction)
//            alert.addAction(cancelAction)
//
//            present(alert, animated: true)
//        }
//    }
//}
//
//extension LocationManager: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
//        print("lat - \(locValue.latitude), lon - \(locValue.longitude)")
//    }
//    
//}
