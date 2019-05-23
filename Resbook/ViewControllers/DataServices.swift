//
//  DataServices.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import Firebase

public class DataServices {
    
    static let sharedInstance = DataServices()
    
    
    
    // Store object
    var userProfile: UserProfile?
    
    var message:Message?
    
    var feedmessage:Channel?

}
