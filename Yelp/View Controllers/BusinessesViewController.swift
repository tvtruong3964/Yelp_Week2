//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Chau Vo on 10/17/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit
import MBProgressHUD

class BusinessesViewController: UIViewController, FilterViewControllerDelegate {

    var searchBar: UISearchBar!
    
    var isMoreDataLoading = false
    var numberResult = 20
    var offset = 0
    var loadingMoreView:InfiniteScrollActivityView?
    
    
    @IBOutlet weak var tableView: UITableView!
    var businesses = [Business]()
//    ! {
//        didSet {
//            print("Bussinesses count: \(businesses.count)")
//        }
//    }
    var yelpSearchSetting = YelpSearchSetting()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // set navibar color
        navigationController!.navigationBar.barTintColor = AppColor.mainColor
        
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
        
        doSearch()

    
    }
    
    @IBAction func next(_ sender: UIBarButtonItem) {
        doLoadMore()
        
    }
    func doSearch() {
        
        //reset offset load more
        offset = 0
        yelpSearchSetting.offset = offset
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        Business.search(yelpSearchSetting: yelpSearchSetting) { (businesses: [Business]?, error: Error?) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if let businesses = businesses {
                
                self.businesses = businesses
//                for business in businesses {
//                    self.businesses.append(business)
//                }
                print("Bussinesses count: \(businesses.count)")
                self.tableView.reloadData()
            }
        }
    }
    
    func doLoadMore() {
        
        offset += numberResult
        yelpSearchSetting.offset = offset
        
        Business.search(yelpSearchSetting: yelpSearchSetting) { (businesses: [Business]?, error: Error?) in
            // Update flag load more
            self.isMoreDataLoading = false
            
            if let businesses = businesses {
                for business in businesses {
                    self.businesses.append(business)
                }
                print("Bussinesses count: \(businesses.count)")
                self.loadingMoreView!.stopAnimating()
                
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filter" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! FilterViewController
            controller.delegate = self
        } else if segue.identifier == "detail" {
            let index = tableView.indexPathForSelectedRow!.row
            let viewController = segue.destination as! DetailViewController
            viewController.business = businesses[index]
        } else if segue.identifier == "map" {
            let viewController = segue.destination as! MapDetailViewController
            viewController.businesses = businesses
        }
        
    }
    
//    func filterViewController(filterVC: FilterViewController, didUpdateFilters filters: [String]) {
//        print("got categories did update: \(filters)")
//        
//        yelpSearchSetting.categories = filters
//        
//        doSearch()
//   }
    
    func filterViewController(filterVC: FilterViewController, sort: YelpSortMode?, distance: Int?, didUpdateFilters filters: [String], deals: Bool?) {
        
        yelpSearchSetting.yelpSortMode = sort
        yelpSearchSetting.radius = distance
        yelpSearchSetting.deals = deals
        yelpSearchSetting.categories = filters
        doSearch()
    }
    

}
extension BusinessesViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        yelpSearchSetting.with = searchBar.text
        doSearch()
    }
}

extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return businesses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusinessesCell", for: indexPath) as! BusinessesCell
        cell.business = businesses[indexPath.row]
        return cell
    }
}

// MARK: - Load More Data
extension BusinessesViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                doLoadMore()
            }
        }
    }
}
