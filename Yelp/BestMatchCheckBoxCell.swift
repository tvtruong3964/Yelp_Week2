//
//  BestMatchCheckBoxCell.swift
//  Yelp
//
//  Created by Truong Tran on 6/23/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
import BEMCheckBox

protocol BestMatchCheckBoxCellDelegate {
    func bestMatchCheckBoxCell(cell: BestMatchCheckBoxCell, value: Bool)
}

class BestMatchCheckBoxCell: UITableViewCell,  BEMCheckBoxDelegate {
    @IBOutlet weak var bestMatchLabel: UILabel!
    @IBOutlet weak var bestMatchCheckbox: BEMCheckBox!
    var delegate: BestMatchCheckBoxCellDelegate!

    override func awakeFromNib() {
        super.awakeFromNib()
        bestMatchCheckbox.delegate = self
    }
    
    func didTap(_ checkBox: BEMCheckBox) {
        delegate.bestMatchCheckBoxCell(cell: self, value: checkBox.on)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
