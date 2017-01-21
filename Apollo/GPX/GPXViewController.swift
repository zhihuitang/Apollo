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
        return "Trax demo"
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
        
        view.isDraggable = annotation is EditableWaypoint
        
        view.leftCalloutAccessoryView = nil
        view.rightCalloutAccessoryView = nil
        if let waypoint = annotation as? GPX.Waypoint {
            if waypoint.thumbnailURL != nil {
                view.leftCalloutAccessoryView = UIButton(frame: Constants.LeftCalloutFrame)
            }
            
            if waypoint is EditableWaypoint {
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.leftCalloutAccessoryView {
            performSegue(withIdentifier: Constants.ShowImageSegue, sender: view)
        } else if control == view.rightCalloutAccessoryView {
            mapView.deselectAnnotation(view.annotation, animated: true)
            performSegue(withIdentifier: Constants.EditUserWayPoint, sender: view)
        }
    }
    
    // MARK: NAVIGATION
    
    // unwind segue
    @IBAction func updatedUserWaypoint(segue: UIStoryboardSegue) {
        if let vc = segue.source.contentViewController as? EditWaypointViewController {
            selectWaypoint(waypoint: vc.waypointToEdit)
        }
    }
    
    
    private func selectWaypoint(waypoint: GPX.Waypoint?) {
        if waypoint != nil {
            mapView.selectAnnotation(waypoint!, animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination.contentViewController
        if let annotationView = sender as? MKAnnotationView,
            let waypoint = annotationView.annotation as? GPX.Waypoint {
            if segue.identifier == Constants.ShowImageSegue {
                if let ivc = destination as? ImageViewController {
                    ivc.imageURL = waypoint.imageURL
                    ivc.title = waypoint.name
                }
            } else if segue.identifier == Constants.EditUserWayPoint {
                if let evc = destination as? EditWaypointViewController, let editableWaypoint = waypoint as? EditableWaypoint {
                    evc.waypointToEdit = editableWaypoint
                }
            }
        }
    }
    @IBAction func addWaypoint(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let coordinate = mapView.convert(sender.location(in: mapView), toCoordinateFrom: mapView)
            let waypoint = EditableWaypoint(latitude: coordinate.latitude, longitude: coordinate.longitude)
            waypoint.name = "Dropped"
            mapView.addAnnotation(waypoint)
            
        }
    }

    private struct Constants {
        static let LeftCalloutFrame = CGRect(x: 0, y: 0, width: 59, height: 59)
        static let AnnotationViewReuseIdentifier = "wayout"
        static let ShowImageSegue = "Show Image"
        static let EditUserWayPoint = "Edit Waypoint"
    }
}

