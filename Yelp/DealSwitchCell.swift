//
//  DealSwitchCell.swift
//  Yelp
//
//  Created by Truong Tran on 6/23/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

protocol DealSwitchCellDelegate {
    func dealSwitchCell(valueSwitch: Bool)
}

class DealSwitchCell: UITableViewCell {
    
    @IBOutlet weak var dealSwitch: UISwitch!
    var delegate: DealSwitchCellDelegate!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        dealSwitch.onImage = UIImage(named: "YelpIcon")
//        dealSwitch.onImage(UIImage(named: "YelpIcon"))
//            dealSwitch.offImage(UIImage(named: "ShowDown"))
        
    }
    @IBAction func dealSwitchChanged(_ sender: UISwitch) {
        delegate.dealSwitchCell(valueSwitch: sender.isOn)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
