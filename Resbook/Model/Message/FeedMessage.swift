//
//  FeedMessage.swift
//  Resbook
//
//  Created by Apple on 5/15/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import ObjectMapper

//public class FeedMessage:Mappable{
//
//     var user_id:String = ""
//     var status:Int = 0
//
//    public required convenience init?(map: Map) {
//        self.init()
//
//    }
//
//    public func mapping(map: Map) {
//
//
//        user_id <- map["user_id"]
//        status <- map["find_status"]
//
//
//    }
//
//
//
//
//
//
//}
public class FeedMessage {
     var user_id:String
     var status:Int

    var _user_id:String{

        return user_id
    }
    var _status:Int{
        return status
    }


    init(user_id:String,status:Int) {

        self.user_id =  user_id
        self.status =   status
        if status == 0{
            
            print("can not find value")
        }
        else{
            
            print("your value here")
        }
    }
    




}
