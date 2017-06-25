//
//  YelpSearchSetting.swift
//  Yelp
//
//  Created by Truong Tran on 6/23/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//
import Foundation
class YelpSearchSetting {
    var with: String?
    var yelpSortMode: YelpSortMode?
    var categories: [String]?
    var deals: Bool?
    var radius: Int?
    var offset: Int?
  
    
    
    
    
    init() {
        with = ""
        yelpSortMode = nil
        categories = nil
        deals = nil
        radius = nil
        
    }
    
//    init(with: String?, yelpSortMode: YelpSortMode?, categories: [String]?, deals: Bool?, radius: Int?) {
//        self.with = with
//        self.yelpSortMode = yelpSortMode
//        self.categories = categories
//        self.deals = deals
//        self.radius = radius
//    }
   
}
