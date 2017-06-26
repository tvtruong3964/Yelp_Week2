//
//  MapDetailViewController.swift
//  Yelp
//
//  Created by Truong Tran on 6/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
import MapKit

class MapDetailViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var businesses: [Business]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        // Remove all annotations
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations(annotationsToRemove )
        
        // Location used in YelpClient API
        var userLocation = CLLocationCoordinate2D()
        userLocation.latitude = 37.785771
        userLocation.longitude = -122.406165
        
        
        // Set radius of 1km -> use 0.01 degree
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: userLocation, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.regionThatFits(region)
        

        for busines in businesses {
            mapView.addAnnotation(busines)
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MapDetailViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is Business else {
            return nil
        }
        let identifier = "Location"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.tintColor = UIColor(white: 0.0, alpha: 0.5)
            pinView.isEnabled = true
            pinView.canShowCallout = true
            pinView.animatesDrop = false
//            pinView.pinTintColor = UIColor(red: 0.32, green: 0.82,
//                                           blue: 0.4, alpha: 1)
            
            let rightButton = UIButton(type: .detailDisclosure)
            rightButton.addTarget(self, action: #selector(showLocationDetails), for: .touchUpInside)
            pinView.rightCalloutAccessoryView = rightButton
            annotationView = pinView
        }
        if let annotationView = annotationView {
            annotationView.annotation = annotation
            
            let button = annotationView.rightCalloutAccessoryView as! UIButton
            if let index = businesses.index(of: annotation as! Business) {
                button.tag = index
            }
        }
        return annotationView
    }
    
    func showLocationDetails(_ sender: UIButton) {
        performSegue(withIdentifier: "viewDetail", sender: sender)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewDetail" {
            let viewController = segue.destination as! DetailViewController
            let button = sender as! UIButton
            viewController.business = businesses[button.tag]
        }
    }
    
}

