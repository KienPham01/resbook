//
//  BookItemParameter.swift
//  Resbook
//
//  Created by Trương Quang Thuỷ on 5/9/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import ObjectMapper

public class BookItemParameter: Mappable {
    var free_loan: Bool?
    var numdays_borrow: Int?
    var owner_id: String? = DataServices.sharedInstance.userProfile?.user_id ?? nil
    var purchase_price: Int?
    var sale_price: Int?
    var user_id: String? = DataServices.sharedInstance.userProfile?.user_id ?? nil
    var quantity: Int?
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        if free_loan != nil {
            free_loan <- map["free_loan"]
        }
        
        if numdays_borrow != nil {
            numdays_borrow <- map["numdays_borrow"]
        }
        
        if owner_id != nil {
            owner_id <- map["owner_id"]
        }
        
        if purchase_price != nil {
            purchase_price <- map["purchase_price"]
        }
        
        if sale_price != nil {
            sale_price <- map["sale_price"]
        }
        
        if user_id != nil {
            user_id <- map["user_id"]
        }
        
        if quantity != nil {
            quantity <- map["quantity"]
        }
    }
}
