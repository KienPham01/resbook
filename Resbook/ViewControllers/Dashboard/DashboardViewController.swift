//
//  DashboardViewController.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/5/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit
import Firebase

class DashboardViewController: UIViewController {
    var userProfile = DataServices.sharedInstance.userProfile
            var feedMessage = [FeedMessage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("your user\(Auth.auth().currentUser?.uid)")
        
    }
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
//        Network.getUserProfile { (completion) in
//            self.userProfile = completion
//            print("+++\(self.userProfile?.user_id)")
//
//        }
//        print("+++\(userProfile?.user_id)")
        
//        getFeed()
        
    }
    
    
    
//    func getFeed()  {
//        
//        print("here your value \(feedMessage)")
//        
//        
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
