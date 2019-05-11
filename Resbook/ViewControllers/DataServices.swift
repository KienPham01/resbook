//
//  DataServices.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import Firebase
let DB_BASE =  Database.database().reference()
class DataServices {
    static let sharedInstance = DataServices()
    
    // Store object
    var userProfile: UserProfile?
    
    private var _REF_BASE = DB_BASE
    
    private var _REF_FEED = DB_BASE.child("conversation")
    
    var REF_FEED:DatabaseReference{
        
        return _REF_FEED
    }
    
    
    
    func getAllFeedMessages(handler:@escaping(_ messages:[Message])->()) {
        
        var messageArray = [Message]()
        REF_FEED.observeSingleEvent(of: .value){(feedMessageSnapshot) in
            
            
            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else {return}
            
            for message in feedMessageSnapshot{
                
                let content =  message.childSnapshot(forPath: "message").value as! String
                let senderId = message.childSnapshot(forPath: "sender_id").value as! String
                let message = Message(content: content, senderId: senderId)
                messageArray.append(message)
            }
            handler(messageArray)
        }
        
        
        
    }
}
