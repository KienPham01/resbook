//
//  UserProfileParameter.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import ObjectMapper

public class UserProfileParameter: Mappable  {
    var mail_address: String = ""
    var user_name: String?
    var address: String?
    var phonenumber: String?
    var password: String?
    
    required convenience public init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        mail_address <- map["mail_address"]
        if password != nil {
            password <- map["password"]
        }
        if user_name != nil {
            password <- map["user_name"]
        }
        if address != nil {
            address <- map["address"]
        }
        if phonenumber != nil {
            phonenumber <- map["phonenumber"]
        }
    }
}
