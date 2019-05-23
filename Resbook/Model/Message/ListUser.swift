//
//  UserSearchProfile.swift
//  Resbook
//
//  Created by Apple on 5/15/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
public class ListUser{
    
    private var _user:String
    private var _avatar:String
    var user:String{
        
        return _user
    }
    var avatar:String
    {
        
        return _avatar
    }
    init(user:String,avatar:String) {
        
        self._user  = user
        self._avatar =  avatar
        
    }
    
    
}
