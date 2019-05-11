//
//  UserProfile.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import ObjectMapper

public class UserProfile: Mappable {

    var avatar: String = ""
    var mail_address: String = ""
    var user_id: String = ""
    var user_name: String = ""
    var user_type: String = ""
    var phonenumber: String = ""
    var address: String = ""
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        avatar <- map["avatar"]
        mail_address <- map["mail_address"]
        user_id <- map["user_id"]
        user_name <- map["user_name"]
        user_type <- map["user_type"]
        phonenumber <- map["phonenumber"]
        address <- map["address"]
    }
}
