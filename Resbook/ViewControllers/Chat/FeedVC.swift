//
//  FeedVC.swift
//  Resbook
//
//  Created by Apple on 5/11/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {
    
    var messageArray = [Message]()
    let userProfile = DataServices.sharedInstance.userProfile


    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
    


}

extension FeedVC:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "feedCell") as? FeedCell else {return UITableViewCell()}
        let meassage = messageArray[indexPath.row]
        
        cell.profileImage.loadImage(url: userProfile?.avatar ?? "",placeHolderImage: #imageLiteral(resourceName: "user"))
        cell.contentLbl.text = meassage.content
        cell.emailLbl.text =  meassage.senderId
        
        return cell
        
    }
    
    
    
}
