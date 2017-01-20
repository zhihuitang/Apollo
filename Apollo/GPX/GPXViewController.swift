//
//  GPXViewController.swift
//  Apollo
//
//  Created by Zhihui Tang on 2017-01-20.
//  Copyright © 2017 Zhihui Tang. All rights reserved.
//

import UIKit
import MapKit

class GPXViewController: BaseViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.mapType = .hybrid
            mapView.delegate = self
        }
    }
    
    override var name: String {
        return "GPX demo"
    }
    
    var gpxURL: NSURL? {
        didSet {
            if let url = gpxURL {
                clearWaypoints()
                GPX.parse(url: url) { gpx in
                    if gpx != nil {
                        self.addWaypoints(waypoints: gpx!.waypoints)
                    }
                }
            }
        }
    }
    
    private func clearWaypoints(){
        if let annotations = mapView?.annotations {
            self.mapView?.removeAnnotations(annotations)
        }
    }
    private func addWaypoints(waypoints: [GPX.Waypoint]){
        mapView?.addAnnotations(waypoints)
        mapView?.showAnnotations(waypoints, animated: true)
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        gpxURL = NSURL(string: "http://cs193p.stanford.edu/Vacation.gpx")
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var view:MKAnnotationView! = mapView.dequeueReusableAnnotationView(withIdentifier: Constants.AnnotationViewReuseIdentifier)
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: Constants.AnnotationViewReuseIdentifier)
            view.canShowCallout = true
        } else {
            view.annotation = annotation
        }
        view.leftCalloutAccessoryView = nil
        if let waypoint = annotation as? GPX.Waypoint {
            if waypoint.thumbnailURL != nil {
                view.leftCalloutAccessoryView = UIButton(frame: Constants.LeftCalloutFrame)
            }
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let thumbnailImageButton = view.leftCalloutAccessoryView as? UIButton,
            let url = (view.annotation as? GPX.Waypoint)?.thumbnailURL,
            let imageData = NSData(contentsOf: url),
            let image = UIImage(data: imageData as Data) {
                thumbnailImageButton.setImage(image, for: .normal)
        
        }
    }
    private struct Constants {
        static let LeftCalloutFrame = CGRect(x: 0, y: 0, width: 59, height: 59)
        static let AnnotationViewReuseIdentifier = "wayout"
        static let ShowImageSegue = "Show Image"
        static let EditUserWayPoint = "Edit Waypoint"
    }
}

