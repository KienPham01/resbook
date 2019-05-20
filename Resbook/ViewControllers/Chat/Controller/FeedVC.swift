//
//  FeedVC.swift
//  Resbook
//
//  Created by Apple on 5/11/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController {
    
    var messageArray = [String]()
    
    var searchRequest = [FeedMessage]()
    

    @IBOutlet weak var chatLbl: UILabel!
    let userProfile = DataServices.sharedInstance.userProfile
//    var message = DataServices.sharedInstance.feedmessage

    @IBOutlet weak var userNameSearch: UITextField!
    
   
    @IBOutlet weak var profile1: UIImageView!{
        
        didSet {
            self.profile1.layer.cornerRadius = self.profile1.frame.width / 2
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let uid = Auth.auth().currentUser?.uid
        
//        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {
//
//            Network.getAllFeed(forUid: (Auth.auth().currentUser?.uid)!, handler: { (returnedFeed) in
//
//                self.messageArray =  returnedFeed
//                self.tableView.reloadData()
//            })
        
            print("best of team\(self.messageArray.count)")
            
            
//        })
            profile1.isHidden = true
            chatLbl.isHidden = true
        
//        }

//        print("your user id\(uid)")
       
        configUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        userNameSearch.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        userNameSearch.delegate = self
        

    }
    
    

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        

        
        
    
        
        
        
        
    }
    
    @objc func textFieldDidChange()
    {
        
        if userNameSearch.text == "" {
            searchRequest = []
            tableView.reloadData()
            
//            profile1.isHidden = true
//            chatLbl.isHidden = true
            
        }
        else{
            
            profile1.isHidden = false
            chatLbl.isHidden = false
            
            
            Network.insertUser(withMessage: userNameSearch.text!, forUid: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (isComplete) in
                
                if isComplete{
                    
                    Network.getSearchUser(handler: { (searchResponse) in
                        
                        self.searchRequest = searchResponse
                        print("test thu\(self.searchRequest)")
                        self.tableView.reloadData()
                        
                    })
                    
                }else{
                    
                    print("got something problem")
                }
            }
            

        }
    }
    
    func configUI()  {
        
        profile1.loadImage(url: userProfile?.avatar ?? "",placeHolderImage: #imageLiteral(resourceName: "user"))

        
    }
 
    


}

extension FeedVC:UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return  searchRequest.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell =  tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell
//        guard  let cell =  tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else { return UITableViewCell()}
        let profileImage = UIImage(named: "user.png")!
        let message = searchRequest[indexPath.row]
        
        if message.status == 0 {
            
            cell?.textLabel?.text = "User not found"
            
        }
        cell?.configureCell(feed: message)
        

    
        
        
        

    
        return cell!

        
    }
    

    
    
}


extension FeedVC:UITextFieldDelegate{


}
