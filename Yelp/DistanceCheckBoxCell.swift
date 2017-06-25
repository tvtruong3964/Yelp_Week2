//
//  DistanceCheckBoxCell.swift
//  Yelp
//
//  Created by Truong Tran on 6/23/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol DistanceCheckBoxCellDelegate {
    func distanceCheckBoxCell(cell: DistanceCheckBoxCell, value: Bool)
}

class DistanceCheckBoxCell: UITableViewCell, BEMCheckBoxDelegate {
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var distanceCheckbox: BEMCheckBox!
    var delegate: DistanceCheckBoxCellDelegate!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        distanceCheckbox.delegate = self
        distanceCheckbox.onAnimationType = BEMAnimationType.bounce
        distanceCheckbox.tintColor = UIColor.red
        distanceCheckbox.onCheckColor = UIColor.red
        distanceCheckbox.tintColorDidChange()
        distanceCheckbox.offAnimationType = BEMAnimationType.bounce
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        delegate.distanceCheckBoxCell(cell: self, value: checkBox.on)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
