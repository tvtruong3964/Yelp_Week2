//
//  ExtendCellData.swift
//  Yelp
//
//  Created by Truong Tran on 6/23/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import Foundation
struct ExtendCellData {
    var title: String
    
    var items: [[String : Any]]
    var collapsed: Bool
    
    init(title: String, items: [[String : Any]], collapsed: Bool = true) {
        self.title = title
        self.items = items
        self.collapsed = collapsed
    }
}
