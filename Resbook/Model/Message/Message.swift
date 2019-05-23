//
//  Message.swift
//  Resbook
//
//  Created by Apple on 5/11/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import ObjectMapper




public class Message {
    
    

    private var _content:String = ""
    private var _senderId:String = ""
    private var _avatar:String = ""
    

    var content:String{
        return _content
    }
    var senderId:String{

        return  _senderId
    }
    var avatar:String{
        
        return _avatar
    }
    init(content:String,senderId:String,avatar:String) {

        self._content = content
        self._senderId = senderId
        self._avatar =  avatar
    }


}
