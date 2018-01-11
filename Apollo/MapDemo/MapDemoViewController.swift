//
//  MapDemoViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-01-20.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit
import MapKit

/**
 http://www.appcoda.com/mapkit-beginner-guide/?sukey=38726ace03821fd3b9670900b8cf536bb21c6fb322749b1f73cbe9287a399dbd1702b906df84ceaa94eeb9634291b0c6
 */
class MapDemoViewController: BaseViewController, MKMapViewDelegate {
    
    let locationManager = CLLocationManager()
    let places = Place.getPlaces()
    
    override var name: String {
        return "MapDemo"
    }
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.showsUserLocation = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        requestLocationAccess()
        addAnnotations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func requestLocationAccess(){
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            logger.d("already have location permission")
            return
            
        case .denied, .restricted:
            logger.d("location access denied")
            
        default:
            print("request location....")
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func addAnnotations() {
        mapView?.delegate = self
        mapView?.addAnnotations(places)
        
        let overlays = places.map { MKCircle(center: $0.coordinate, radius: 100) }
        mapView?.addOverlays(overlays)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        } else {
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
            annotationView.image = UIImage(named: "place icon")
            return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKCircleRenderer(overlay: overlay)
        renderer.fillColor = UIColor.black.withAlphaComponent(0.5)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 2
        return renderer
    }
    
}
