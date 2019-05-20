//
//  Channel.swift
//  Resbook
//
//  Created by Apple on 5/19/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation

public class Channel {
    private var _key:String = ""
    private var _red:Int = 0
    
    var key:String{
        
        return _key
    }
    
    var red:Int{
        
        return _red
    }
    
    init(key:String,red:Int) {
        
        self._key = key
        self._red = red
    }
    
    
    
}
