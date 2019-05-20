//
//  DataServices.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import Firebase

class DataServices {
    static let sharedInstance = DataServices()
    
    
    
    // Store object
    var userProfile: UserProfile?
    
    var message:Message?
    
    var feedmessage:Channel?

    
    
//     public static func getAllFeedMessages(handler: @escaping (_ messages: [Message]) -> ()) {
//        var messageArray = [Message]()
//
//        let userID = Auth.auth().currentUser?.uid
////        ref.child("conversation/receivers/\(userID)/new_message_count").observeSingleEvent(of: .value, with: { (feedMessageSnapshot) in
//        AppDelegate.sharedInstance.ref.database.reference(withPath: "conversation/receivers/\(userID)/new_message_count").observe(.value) { (feedMessageSnapshot) in
//
//            guard let feedMessageSnapshot = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
//
//            for message in feedMessageSnapshot {
//
//                let senderId = message.childSnapshot(forPath: "sender_id").value as! String
//                let content = message.childSnapshot(forPath: "content").value as! String
//
//                let message = Message(content: content, senderId: senderId)
//
//                messageArray.append(message)
//
//            }
//                handler(messageArray)
//
//        }
//
//
//    }
}

    
    


    

        
        
        
    

