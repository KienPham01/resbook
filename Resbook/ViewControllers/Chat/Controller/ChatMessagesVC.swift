//
//  ChatMessagesVC.swift
//  Resbook
//
//  Created by Apple on 5/11/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit

class ChatMessagesVC: UIViewController {

    @IBOutlet weak var chatTableView: UITableView!
    
    var messages = [
        "Hello!",
        "Hi there!",
        "Here's\na\nlonger\nmessage",
        "Wow, multiline messages!"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 10.0
        

    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatMessagesVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ChatMessagesCell{
            
            cell.senderMessage.text =  messages[indexPath.row]
            cell.senderMessage.cornerRadius = 15
            
            
            return cell
        }
        return ChatMessagesCell()
        
        
    }
    
   
    
    
    
    
}
