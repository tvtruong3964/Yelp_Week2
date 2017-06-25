//
//  BusinessesCell.swift
//  Yelp
//
//  Created by Truong Tran on 6/21/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
import AFNetworking
class BusinessesCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var reviewCount: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    var business: Business! {
        didSet {
          //  posterImage.setImageWith(business.imageURL!)
            
            
            if business.imageURL != nil {
                posterImage.alpha = 0.0
                UIView.animate(withDuration: 0.3, animations: {
                    self.posterImage.setImageWith(self.business.imageURL!)
                    self.posterImage.alpha = 1.0
                }, completion: nil)
            }
            
            name.text = business.name
            address.text = business.address
            ratingImage.setImageWith(business.ratingImageURL!)
            categories.text = business.categories
            reviewCount.text = "\(String(describing: business.reviewCount!)) reviews"
            distance.text = business.distance
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
