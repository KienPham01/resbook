//
//  BookInformationParameter.swift
//  Resbook
//
//  Created by Trương Quang Thuỷ on 5/8/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import ObjectMapper

public class BookInformationParameter: Mappable {
    var name: String?
    var author_id: String?
    var author_name: String?
    var category_id: String?
    var category_name: String?
    var plot_overview: String?
    var cover_price: Int?
    var image: String?
    var creator: String? = DataServices.sharedInstance.userProfile?.user_id ?? nil
    var create_time: Int64 = Date().toInt()
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        if name != nil {
            self.name <- map["name"]
        }
        
        if author_id != nil {
            self.author_id <- map["author_id"]
        }
        
        if author_name != nil {
            self.author_name <- map["author_name"]
        }
        
        if category_id != nil {
            self.category_id <- map["category_id"]
        }
        
        if category_name != nil {
            self.category_name <- map["category_name"]
        }
        
        if plot_overview != nil {
            self.plot_overview <- map["plot_overview"]
        }
        
        if cover_price != nil {
            self.cover_price <- map["cover_price"]
        }
        
        if creator != nil {
            self.creator <- map["creator"]
        }
        
        self.create_time <- map["create_time"]
        
        if image != nil {
            self.image <- map["image"]
        }
        
    }
}
