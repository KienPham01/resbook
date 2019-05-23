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
    
    var messageArray = [Channel]()
    
    var searchRequest = [FeedMessage]()
    var listUser  = [ListUser]()
    var chosenUserArray = [String]()
    
    var index = IndexPath()
    var userIds = [String]()
    
    var names = ["Arthur", "Ford", "Trillian", "Zaphod", "Marvin"]

    @IBOutlet weak var chatLbl: UILabel!
    let userProfile = DataServices.sharedInstance.userProfile

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
        
            print("best of team\(self.messageArray.count)")
        
        

       
        configUI()
        
        tableView.delegate = self
        tableView.dataSource = self
        userNameSearch.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
        userNameSearch.delegate = self
        

    }
    
    

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    
        (userIds.append(Auth.auth().currentUser?.uid ?? ""))
        
        
        
    
        
    }
    
    @objc func textFieldDidChange()
    {
        
        if userNameSearch.text == "" {
            searchRequest = []
            tableView.reloadData()
            
            
        }
        else{
        
            Network.instance.insertUser(withMessage: userNameSearch.text!, forUid: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (isComplete) in
                
                if isComplete{
                    
                    Network.instance.getSearchUser(handler: { (searchResponse) in
                        
                        self.searchRequest = searchResponse
                        print("test thu\(self.searchRequest)")
                        
                        DispatchQueue.main.async {
                            
                            self.tableView.reloadData()
                        }
                        

                        
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
    
    func creteConversation()  {
        Network.instance.getIds(forUsernames:  chosenUserArray) { (idsArray) in
            
            var userIds = idsArray
            userIds.append((Auth.auth().currentUser?.uid)!)
            Network.instance.createConversation(forUserIds: userIds, handler: { (conversationCreated) in
                    if conversationCreated{
                
                        self.dismiss(animated: true, completion:  nil)
                    }
            
            })
            
        }
        
    }
 
    


}

extension FeedVC:UITableViewDataSource,UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userNameSearch.text != "" {

            return searchRequest.count
        }

        return messageArray.count
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell{
//            let profileImage = UIImage(named: "user.png")!
            let searchResult = searchRequest[indexPath.row]
            
            
            Network.instance.getUsername(forUID: searchResult.user_id) { (email) in
                
                
                cell.configureCell(userid: email, status: searchResult.status, avatar: "")
            }
            
            return cell
        
        
        }
       
        return FeedCell()

        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell{
            let searchResult = searchRequest[indexPath.row]
            
            
            chosenUserArray.append(searchResult._user_id)
            Network.instance.createConversation(forUserIds: chosenUserArray) { (conversationCreated) in
                
                if conversationCreated{
                    let chatVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatMessage")
                    self.present(chatVC!, animated: true, completion: nil)
                } else{
                    print("Please try again")
                }
                
            }
            

            
            
            
        }
        

        
        
    }
    
    

    
    
}


extension FeedVC:UITextFieldDelegate{
    
    


}
