//
//  Category.swift
//  Resbook
//
//  Created by Trương Quang Thuỷ on 5/9/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import ObjectMapper

class Category: ImmutableMappable {
    var uid: String = ""
    var avatar: String = ""
    var name: String = ""
    
    required convenience public init(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
         self.uid <- map["uid"]
        self.avatar <- map["avatar"]
        self.name <- map["name"]
        
    }
}
