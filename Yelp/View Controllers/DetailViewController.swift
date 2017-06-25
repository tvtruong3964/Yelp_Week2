//
//  DetailViewController.swift
//  Yelp
//
//  Created by Truong Tran on 6/26/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
import AFNetworking

class DetailViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rateImage: UIImageView!
    @IBOutlet weak var radius: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var avata: UIImageView!
    @IBOutlet weak var comment: UILabel!
    
    
    var business: Business!
//    {
//        didSet {
//            name.text = business.name
//            address.text = business.address
//            radius.text = business.distance
//            rateImage.setImageWith(business.imageURL!)
//            avata.setImageWith(business.snippetImage!)
//            comment.text = business.snippetText
//            category.text = business.categories
//            
//        }
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        name.text = business.name
        address.text = business.address
        radius.text = business.distance
        rateImage.setImageWith(business.ratingImageURL!)
        avata.setImageWith(business.snippetImage!)
        comment.text = business.snippetText
        category.text = business.categories
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
