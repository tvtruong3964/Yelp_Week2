//
//  DetailViewController.swift
//  Yelp
//
//  Created by Truong Tran on 6/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
import AFNetworking
import MapKit

class DetailViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rateImage: UIImageView!
    @IBOutlet weak var radius: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var avata: UIImageView!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var scrollDetail: UIScrollView!
    
    var business: Business!

    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = business.name
        address.text = business.address
        radius.text = business.distance
        rateImage.setImageWith(business.ratingImageURL!)
        avata.setImageWith(business.snippetImage!)
        comment.text = business.snippetText
        category.text = business.categories
        
        lineView.backgroundColor = AppColor.headerTableColor
        comment.sizeToFit()
        scrollDetail.contentSize = CGSize(width: scrollDetail.bounds.width, height: comment.frame.size.height)
        
        
    
        
        // Remove all annotations
        let annotationsToRemove = mapView.annotations.filter { $0 !== mapView.userLocation }
        mapView.removeAnnotations(annotationsToRemove )
        
        // Location used in YelpClient API
        var userLocation = CLLocationCoordinate2D()
        userLocation.latitude = 37.785771
        userLocation.longitude = -122.406165
        
        
        // Set radius of 1km -> use 0.01 degree
        let span = MKCoordinateSpanMake(0.007, 0.007)
        let region = MKCoordinateRegion(center: userLocation, span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.regionThatFits(region)
        
        mapView.addAnnotation(business)
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
