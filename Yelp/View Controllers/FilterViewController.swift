//
//  FilterViewController.swift
//  Yelp
//
//  Created by Truong Tran on 6/22/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit
protocol FilterViewControllerDelegate {
    func filterViewController(filterVC: FilterViewController,sort: YelpSortMode?, distance: Int?,  didUpdateFilters filters: [String], deals: Bool?)
}

class FilterViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var switchStates = [Int: Bool]()
    
    var switchCategoryArray: [Bool]?
    
    
    
    var dealSwitch = false
    
//    var checkBoxBestMatchStates = [Int: Bool]()
//    var checkBoxDistancelStates = [Int: Bool]()
    
    var delegate: FilterViewControllerDelegate!
    var yelpSortMode: YelpSortMode?
    var categories = [String]()
    var deals: Bool?
    var radius: Int?
    var checkBoxBestMatchSelectIndex = 1
    var checkBoxDistancelSelectIndex = 1
    
    var isFullDataCategory = false
    var labelBottomCell = "See More"
    var isShowTitleDistance = true
    var isShowTitleBestMatch = true
    
    
    
    var extendDistanceData = ExtendCellData(title: "Distance", items: [["name": "Auto", "value": 0],
                                                       ["name": "0.5 km", "value": 500],
                                                       ["name": "2 km", "value": 2000],
                                                       ["name": "5 km", "value": 5000],
                                                       ["name": "15 km", "value": 15000]])
    
    var extendBestMatchData = ExtendCellData(title: "Sort By",items:
                                                    [["name": "Best Match", "value": 0],
                                                    ["name": "Distance", "value": 1],
                                                    ["name": "Rating", "value": 2]])
    
    func registerDefaults() {
        let dictionary: [String: Any] = ["checkBoxBestMatchSelectIndex": 1,
                                         "checkBoxDistancelSelectIndex" : 1,
                                         "dealSwitch": false,
                                         "switchCategoryArray": Array(repeating: false, count: YelpHelper.yelpCategory().count)]
        UserDefaults.standard.register(defaults: dictionary)
        UserDefaults.standard.synchronize()
    }
    func readValueFilter() {
        // read value filter
        checkBoxDistancelSelectIndex = UserDefaults.standard.integer(forKey: "checkBoxDistancelSelectIndex")
        
        checkBoxBestMatchSelectIndex = UserDefaults.standard.integer(forKey: "checkBoxBestMatchSelectIndex")
        dealSwitch = UserDefaults.standard.bool(forKey: "dealSwitch")
        switchCategoryArray = UserDefaults.standard.array(forKey: "switchCategoryArray") as? [Bool]
        
        
        for (index, value) in switchCategoryArray!.enumerated() {
            if value {
                switchStates[index] = value
            }
        }
    }
    
    func saveValueFilter() {
        UserDefaults.standard.set(checkBoxDistancelSelectIndex, forKey: "checkBoxDistancelSelectIndex")
        UserDefaults.standard.set(checkBoxBestMatchSelectIndex, forKey: "checkBoxBestMatchSelectIndex")
        
        UserDefaults.standard.set(dealSwitch, forKey: "dealSwitch")
        UserDefaults.standard.set(switchCategoryArray, forKey: "switchCategoryArray")
        UserDefaults.standard.synchronize()
    }
    func resetFilter() {
        checkBoxBestMatchSelectIndex = 1
        checkBoxDistancelSelectIndex = 1
        dealSwitch = false
        switchCategoryArray = Array(repeating: false, count: YelpHelper.yelpCategory().count)
        
        saveValueFilter()
        
        //update to view
       // extendDistanceData.title = "Auto"
        //extendBestMatchData.title = "Best Match"
        
//        for (index, value) in switchCategoryArray!.enumerated() {
//            if value {
//                switchStates[index] = value
//            }
//        }
        switchStates.removeAll()
       // readValueFilter()
        tableView.reloadData()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        registerDefaults()
        readValueFilter()
        
        // set navibar color
        navigationController!.navigationBar.barTintColor = AppColor.mainColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
 
    @IBAction func save(_ sender: Any) {
        
        
        radius = extendDistanceData.items[checkBoxDistancelSelectIndex - 1]["value"] as? Int
        if radius == 0 {
            radius = nil
        }
        
        
        
        yelpSortMode = YelpSortMode(rawValue:  (extendBestMatchData.items[checkBoxBestMatchSelectIndex - 1]["value"] as! Int))
        
        // get category array when swith have true
      
        for (index, value) in switchStates {
            if value {
                categories.append(YelpHelper.yelpCategory()[index]["code"]!)
                // save value swift in switch array
                switchCategoryArray?[index] = true
            }else {
                switchCategoryArray?[index] = false
            }
        }
        
      //  print(switchCategoryArray)
        
        deals = dealSwitch
        
        
       saveValueFilter()
        
        self.delegate.filterViewController(filterVC: self, sort: yelpSortMode, distance: radius, didUpdateFilters: categories, deals: deals)
        dismiss(animated: true, completion: nil)
    }
 
    @IBAction func onResetFilterClick(_ sender: Any) {
        let alert = UIAlertController(title: "Reset All Filter", message: "Do you want to reset all filter ?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Reset", style: UIAlertActionStyle.destructive, handler: {_ in self.resetFilter()}))
        present(alert, animated: true, completion: nil)
    }


}

extension FilterViewController: UITableViewDataSource, UITableViewDelegate, FilterCellDelegate, DealSwitchCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        switch section {
//            case 0:
//                return ""
//            case 1:
//                return "Distance"
//            case 2:
//                return "Sort By"
//            case 3:
//                return "Category"
//            default:
//                return "Filter"
//        }
//    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
       
        let title = UILabel(frame: CGRect(x: 15, y: 15, width: 200, height: 35))
        
        switch section {
        case 0:
            title.text = ""
        case 1:
            title.text = "Distance"
        case 2:
            title.text = "Sort By"
        case 3:
            title.text = "Category"
        default:
            title.text = "Filter"
        }
        title.textColor = AppColor.mainColor
        view.addSubview(title)
        view.backgroundColor = AppColor.headerTableColor
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
            case 0:
                return 0
            case 1:
                return 50
            case 2:
                return 50
            case 3:
                return 50
            default:
                return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
                return 45
            case 1:
                if indexPath.row == 0 {
                    return isShowTitleDistance ? 45 : 0
                } else{
                    return extendDistanceData.collapsed ? 0 : 45
                }
            
            case 2:
                if indexPath.row == 0 {
                    return isShowTitleBestMatch ? 45 : 0
                } else{
                    return extendBestMatchData.collapsed ? 0 : 45
                }
            
            case 3:
                // visit 3 row and bottom row when not fulldata else visit all
                if !isFullDataCategory {
                    switch indexPath.row {
                        case 0, 1, 2, YelpHelper.yelpCategory().count:
                            return 45
                        default:
                            return 0
                    }
                } else {
                   return 45
                }
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return extendDistanceData.items.count + 1
        case 2:
            return extendBestMatchData.items.count + 1
        case 3:
            return YelpHelper.yelpCategory().count + 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DealSwitchCell") as! DealSwitchCell
            cell.dealSwitch.isOn = dealSwitch
            cell.delegate = self
            return cell
        case 1:
            if indexPath.row == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "DistanceHeaderCell") as! DistanceHeaderCell
                cell.distanceTitle.text = extendDistanceData.items[checkBoxDistancelSelectIndex - 1]["name"] as? String
                 return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "DistanceCheckBoxCell") as! DistanceCheckBoxCell
                cell.delegate = self
                if indexPath.row == checkBoxDistancelSelectIndex {
                    cell.distanceCheckbox.on = true
                } else {
                    cell.distanceCheckbox.on = false
                }
                cell.distanceLabel.text = extendDistanceData.items[indexPath.row - 1]["name"] as? String
                return cell
            }
            
           
        case 2:
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BestMatchHeaderCell") as! BestMatchHeaderCell
                cell.bestMatchTitle.text = extendBestMatchData.items[checkBoxBestMatchSelectIndex - 1]["name"] as? String
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "BestMatchCheckBoxCell") as! BestMatchCheckBoxCell
                cell.delegate = self
                if indexPath.row == checkBoxBestMatchSelectIndex {
                    cell.bestMatchCheckbox.on = true
                } else {
                    cell.bestMatchCheckbox.on = false
                }
//                checkBoxBestMatchStates[checkBoxBestMatchSelectIndex] = true
//                cell.bestMatchCheckbox.on = checkBoxBestMatchStates[indexPath.row] ?? false
                
                cell.bestMatchLabel.text = extendBestMatchData.items[indexPath.row - 1]["name"] as? String
                return cell
            }
            
        case 3:
            if indexPath.row == YelpHelper.yelpCategory().count {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryBottomCell") as! BottomCell
                cell.label.text = labelBottomCell
                return cell
            } else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell") as! FilterCell
                cell.category.text = YelpHelper.yelpCategory()[indexPath.row]["name"]
                cell.switchButton.isOn = switchStates[indexPath.row] ?? false
                //cell.switchButton.isOn = (switchCategoryArray?[indexPath.row])!
                cell.delegate = self
                return cell
            }
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DealSwitchCell", for: indexPath) as! DealSwitchCell
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            return
        case 1:
            if indexPath.row == 0 {
                extendDistanceData.collapsed = !extendDistanceData.collapsed
                isShowTitleDistance = false
                tableView.beginUpdates()
                for i in 0 ..< extendDistanceData.items.count + 1 {
                    tableView.reloadRows(at: [IndexPath(row: i, section: 1)], with: .automatic)
                }
                tableView.endUpdates()
            } else {
                updateTableWhenDistanceSelect(row: indexPath.row)
            }
        case 2:
            if indexPath.row == 0 {
                extendBestMatchData.collapsed = !extendBestMatchData.collapsed
                
                isShowTitleBestMatch = false
                tableView.beginUpdates()
                for i in 0 ..< extendBestMatchData.items.count + 1 {
                    tableView.reloadRows(at: [IndexPath(row: i, section: 2)], with: .automatic)
                }
                tableView.endUpdates()
            } else {
                
               updateTableWhenBestMatchSelect(row: indexPath.row)
            }
        case 3:
            if indexPath.row == YelpHelper.yelpCategory().count {
                isFullDataCategory = !isFullDataCategory
                if isFullDataCategory {
                    labelBottomCell = "Hide"
                } else {
                    labelBottomCell = "See More"
                }
                
                tableView.beginUpdates()
                for i in 0 ..< YelpHelper.yelpCategory().count + 1 {
                    tableView.reloadRows(at: [IndexPath(row: i, section: 3)], with: .automatic)
                }
                tableView.endUpdates()
            }
            
        default:
            return
        }
    }
    
    func dealSwitchCell(valueSwitch: Bool) {
        dealSwitch = valueSwitch
    }
    
    func fillterCell(cell: FilterCell, didChangeValue value: Bool) {
        let index = tableView.indexPath(for: cell)?.row
        switchStates[index!] = value
       // print(switchStates)
//        for (index, value) in switchStates {
//            if value {
//                switchCategoryArray?[index] = true
//            }else {
//                switchCategoryArray?[index] = false
//            }
//        }
    }
    
    
    
    func updateTableWhenDistanceSelect(row: Int) {
       
        
        
        let cellSelect = tableView.cellForRow(at: IndexPath(row: row, section: 1)) as! DistanceCheckBoxCell
        cellSelect.distanceCheckbox.on = true
        
        
        // update data to array
       // extendDistanceData.title = resultTitleSelect as! String
        
        
        // update value radius
       // radius = row == 1 ? nil : extendDistanceData.items[row - 1]["value"] as? Int
        
        // upload checkbox index
        checkBoxDistancelSelectIndex = row
        
        tableView.beginUpdates()
        for i in 0 ..< self.extendDistanceData.items.count + 1 {
            tableView.reloadRows(at: [IndexPath(row: i, section: 1)], with: .automatic)
        }
        tableView.endUpdates()
        
        // delay 0.5s to user can see checkbox tick, then update hide row
        let when = DispatchTime.now() + 0.3 // + number second
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.extendDistanceData.collapsed = !self.extendDistanceData.collapsed
            
            // show title distance
            self.isShowTitleDistance = true
            
            self.tableView.beginUpdates()
            for i in 0 ..< self.extendDistanceData.items.count + 1 {
                self.tableView.reloadRows(at: [IndexPath(row: i, section: 1)], with: .automatic)
            }
            self.tableView.endUpdates()
        }
    }
    
    func updateTableWhenBestMatchSelect(row: Int) {
        
        
        
        let cellSelect = tableView.cellForRow(at: IndexPath(row: row, section: 2)) as! BestMatchCheckBoxCell
        cellSelect.bestMatchCheckbox.on = true
        
        // update data to array
       // extendBestMatchData.title = resultTitleSelect as! String
        
        
        
        // update value
        //yelpSortMode = YelpSortMode(rawValue:  (extendBestMatchData.items[row - 1]["value"] as! Int))
        
        // upload checkbox index
        checkBoxBestMatchSelectIndex = row
        
        tableView.beginUpdates()
        for i in 0 ..< self.extendBestMatchData.items.count + 1 {
            tableView.reloadRows(at: [IndexPath(row: i, section: 2)], with: .automatic)
        }
        tableView.endUpdates()
        
        // delay 0.5s to user can see checkbox tick, then update hide row
        let when = DispatchTime.now() + 0.3 // + number second
        DispatchQueue.main.asyncAfter(deadline: when) {
    
            // show title best match
            self.isShowTitleBestMatch = true
            
            self.extendBestMatchData.collapsed = !self.extendBestMatchData.collapsed
            self.tableView.beginUpdates()
            for i in 0 ..< self.extendBestMatchData.items.count + 1 {
                self.tableView.reloadRows(at: [IndexPath(row: i, section: 2)], with: .automatic)
            }
            self.tableView.endUpdates()
        }
    }
}

// MARK - Checkbox cell click
extension FilterViewController: DistanceCheckBoxCellDelegate, BestMatchCheckBoxCellDelegate{
    func distanceCheckBoxCell(cell: DistanceCheckBoxCell, value: Bool) {
        
        updateTableWhenDistanceSelect(row: (tableView.indexPath(for: cell)?.row)!)
    }
    
    func bestMatchCheckBoxCell(cell: BestMatchCheckBoxCell, value: Bool) {
        updateTableWhenBestMatchSelect(row: (tableView.indexPath(for: cell)?.row)!)
    }
}
