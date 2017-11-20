//
//  LocationDemoViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-09-17.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit
import CoreLocation

class LocationDemoViewController: UIViewController {
    
    @IBOutlet weak var entry: UITextField!
    @IBOutlet weak var results: UILabel!
    @IBOutlet weak var lookupType: UISegmentedControl!
    lazy var geocoder: CLGeocoder = {
        return CLGeocoder()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func lookupGeocoding(_ sender: UIButton) {
        let text = entry.text ?? ""
        if lookupType.selectedSegmentIndex == 0 {
            // address
            
            self.geocoder.geocodeAddressString(text) { [weak self] placemarks, error in
                if let placemark = placemarks?.first,
                let latitude = placemark.location?.coordinate.latitude,
                    let longitude = placemark.location?.coordinate.longitude {
                    let coordinates = "\(latitude) \(longitude)"
                    self?.results.text = coordinates
                }
            }
        } else {
            // reverse
            let coords = text.components(separatedBy: ",")
            if coords.count < 2 {
                return
            }
            let latitude = Double(coords[0].trimmingCharacters(in: .whitespacesAndNewlines))
            let longtitude = Double(coords[1].trimmingCharacters(in: .whitespacesAndNewlines))
            let location = CLLocation(latitude: latitude!, longitude: longtitude!)
            self.geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
                if let placemark = placemarks?.first,
                    let streetNumber = placemark.subThoroughfare,
                    let street = placemark.thoroughfare,
                    let city = placemark.locality,
                    let state = placemark.administrativeArea {
                    let address = "\(streetNumber) \(street) \(city), \(state)"
                    self?.results.text = address
                }
            }
        }
    }

}

extension LocationDemoViewController: DemoView {
    var name: String { return "Location demos" }
    var classIdentity: String? {
        return self.className
    }
}

