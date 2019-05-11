//
//  Author.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/8/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import ObjectMapper

class Author: ImmutableMappable  {
    var uid: String = ""
    var contry: String = ""
    var nick_name: String = ""
    var avatar: String = ""
    var name: String = ""
    
    required convenience public init(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        self.uid <- map["uid"]
        self.avatar <- map["avatar"]
        self.name <- map["name"]
        self.contry <- map["contry"]
        self.nick_name <- map["nick_name"]
    }
}
