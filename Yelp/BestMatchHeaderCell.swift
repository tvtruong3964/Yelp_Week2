//
//  BestMatchHeaderCell.swift
//  Yelp
//
//  Created by Truong Tran on 6/23/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

class BestMatchHeaderCell: UITableViewCell {
    @IBOutlet weak var imgBestMatchHeader: UIImageView!
    @IBOutlet weak var bestMatchTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
