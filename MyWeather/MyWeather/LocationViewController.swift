//
//  LocationViewController.swift
//  Movie App
//
//  Created by terrence lynch on 8/12/17.
//  Copyright © 2017 terrence lynch. All rights reserved.
//

import UIKit
import CoreLocation


class LocationViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var issues:[String: [String:AnyObject]]?
    var issueDictionary: [String:Any] = [:]
    
    var isLoadingViewController = false
   
    var location : CLLocation!
    
    let locationManager = CLLocationManager()
    
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        //locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        //locationManager.startUpdatingLocation()
        
        isLoadingViewController = true
        locationManager.requestLocation()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isLoadingViewController {
            isLoadingViewController = false
        }
        else {
            locationManager.requestLocation()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


extension LocationViewController : CLLocationManagerDelegate {
    
    @objc(locationManager:didChangeAuthorizationStatus:) func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        SharedNetworking.sharedInstance.showNetworkIndicator()
        
        if let location = locations.last {
            print("location:: \(location)")
            //locationLabel.text = String(describing: location)
            let altitude = location.altitude
            print("altitude:: \(altitude)")
            
            let feetAlt = altitude * 3.2808
            
            let roundAlt = String(format: "%.2f", feetAlt)
            
            print("roundAlt: \(roundAlt)")
            
            altitudeLabel.text = String(describing: roundAlt) + " ft"
            
            let myLatitude = location.coordinate.latitude
            let myLongitude = location.coordinate.longitude
            print(myLatitude)
            print(myLongitude)
            
            self.geocode(myLatitude, myLongitude)
        }
        SharedNetworking.sharedInstance.hideNetworkIndicator()
    }

    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: (error)")
    }
    

    func geocode(_ latitude: Double, _ longitude: Double) {
        
        print("geocode")
        print(latitude, longitude)
        
        let lat = latitude
        let lng = longitude

        //let lat = 37.78735890
        //let lng = -122.40822700
        
        let geocoder = CLGeocoder()

        // Create Location
        let location = CLLocation(latitude: lat, longitude: lng)
        
        print(location)

        // Geocode Location
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in

            // Process Response
            guard (error == nil), let placemarks = placemarks else {
                print("Error in geocoding: \(error!.localizedDescription)")
                return
            }
            if let placemark = placemarks.first {
                self.displayLocationInfo(placemark: placemark)
            }
        }
    }
    
    
    func displayLocationInfo(placemark: CLPlacemark) {
        
        print(placemark)
        var tempString : String = ""
        
        if (placemark.locality != nil) {
            //cityLabel.text = placemark.locality
            tempString = tempString + placemark.locality! + "\n"
        }
        if (placemark.administrativeArea != nil) {
            //cityLabel.text = placemark.locality
            tempString = tempString + placemark.administrativeArea! + "\n"
        }
        
        cityLabel.text = tempString
        print(tempString)
        
        let formattedCity = placemark.locality!.replacingOccurrences(of: " ", with: "%20")
        print(formattedCity)
        
        let urlString = "https://api.wunderground.com/api/c20aa53f37c0654b/conditions/q/\(placemark.administrativeArea!)/\(formattedCity).json"
        print(urlString)
        
        print("one")
        
        //SharedNetworking.sharedInstance.showNetworkIndicator()
        
        print("two")
        
        SharedNetworking.sharedInstance.getIssues(url: urlString) { (issues) in
            
            self.createDictionary(issues: issues! as! [String : [String : AnyObject]])
            print("HI \(self.issueDictionary)")
            
            // The data is available in this closure through the `issues` variable
            
            // Copy the `issues` to a property of the view controller so that it can
            // persist beyond the closure block.  The property should
            // be of the same type as the parameter here (eg [[String: AnyObject]]?)
            
            // Reload the table.  The tables data source should be the property you copied the
            // issues to (above). Remember to refresh the table on the main thread
            
            print("three")
            
            DispatchQueue.main.async {
        
                self.locationLabel.text = (self.issueDictionary["temp"] as? String)
            }
            
            // For debugging
            //print(issues as Any)
            
            print("four")
            //SharedNetworking.sharedInstance.hideNetworkIndicator()
        }
    }

    
    func createDictionary(issues: [String: [String:AnyObject]]) {
        
        let numIssues = issues.count
        print("numIssues: \(numIssues)")
        
        //print(issues)
        
        print()
        print(issues["current_observation"]!["display_location"]!["city"] as! String)
        print(issues["current_observation"]!["icon"] as! String)
        print(issues["current_observation"]!["icon_url"] as! String)
        print(issues["current_observation"]!["weather"] as! String)
        
        issueDictionary = [String:Any]()
        
        var city = ""
        var temp = ""
        var icon = ""
        var icon_url = ""
        var weather = ""
        
        if (issues["current_observation"] != nil) {
            
            city = (issues["current_observation"]!["display_location"]!["city"] as! String)
            temp = (issues["current_observation"]!["temperature_string"] as! String)
            icon = (issues["current_observation"]!["icon"] as! String)
            icon_url = (issues["current_observation"]!["icon_url"] as! String)
            weather = (issues["current_observation"]!["weather"] as! String)
            
            //icon_url = "http://icons.wxug.com/i/c/i/" + icon + ".gif"
            //print(icon_url)
            
            issueDictionary = ["city":city, "temp":temp, "icon":icon, "icon_url":icon_url, "weather":weather]
        }
    }
}














