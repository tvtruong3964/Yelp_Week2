//
//  FilterCell.swift
//  Yelp
//
//  Created by Truong Tran on 6/22/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol FilterCellDelegate {
    func fillterCell(cell: FilterCell, didChangeValue value: Bool)
}

class FilterCell: UITableViewCell {
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    var delegate: FilterCellDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func switchChange(_ sender: UISwitch) {
        //print("switch change to \(sender.isOn)")
        self.delegate.fillterCell(cell: self, didChangeValue: sender.isOn)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
