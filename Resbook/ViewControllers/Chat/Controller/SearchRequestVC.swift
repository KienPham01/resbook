////
////  SearchRequestVC.swift
////  Resbook
////
////  Created by Apple on 5/19/19.
////  Copyright © 2019 Thuy Truong Quang. All rights reserved.
////
//
//import UIKit
//import Firebase
//
//class SearchRequestVC: UIViewController {
//
//    
////    var searchResult = [String]()
//    @IBOutlet weak var searchResultTableview: UITableView!
//    @IBOutlet weak var userNameSearch: UITextField!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        searchResultTableview.delegate = self
//        searchResultTableview.dataSource = self
//        
//        userNameSearch.addTarget(self, action: #selector(textFieldDidChange), for: .editingDidEnd)
//
//        
//        
//
//        // Do any additional setup after loading the view.
//    }
//    
//    
//    
//    @IBAction func cancelWasPressed(_ sender: Any) {
//        
//        
//    }
//    
//    
//    
//    @objc func textFieldDidChange()
//    {
//        
//        if userNameSearch.text == "" {
//            searchResultTableview.reloadData()
//            
//        }
//        else{
//            
//            Network.instance.insertUser(withMessage: userNameSearch.text!, forUid: (Auth.auth().currentUser?.uid)!, withGroupKey: nil) { (isComplete) in
//                
//                if isComplete{
//                    
//                    Network.instance.getSearchUser(handler: { (searchResponse) in
//                        
////                        self.searchResult = searchResponse
////                        self.searchResultTableview.reloadData()
//                        
//                        //                        self.messageArray = searchResponse
//                        
//                    })
//                    
//                }else{
//                    
//                    print("got something problem")
//                }
//            }
//            
//            
//        }
//    }
//    
//
//
//}
//
//extension SearchRequestVC:UITableViewDelegate,UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return searchResult.count
//        
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? SearchRequestCell else {return SearchRequestCell()}
//        
//        let username = searchResult[indexPath.row]
//        cell.userNameLbl.text = username
//        
//        return cell
//        
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
