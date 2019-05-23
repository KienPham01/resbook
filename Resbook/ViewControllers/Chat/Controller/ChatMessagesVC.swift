//
//  ChatMessagesVC.swift
//  Resbook
//
//  Created by Apple on 5/11/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit
import  Firebase
class ChatMessagesVC: UIViewController {
    
    var channel:Channel?
    
    var channelMessages = [Message]()

    @IBOutlet weak var chatTableView: UITableView!
    
    
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var messageTextField: InsetTextField!
    var messages = [
        "Hello!",
        "Hi there!",
        "Here's\na\nlonger\nmessage",
        "Wow, multiline messages!"
    ]
    func initData(forChanel channel:Channel)  {
        self.channel = channel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 10.0
        

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    AppDelegate.sharedInstance.ref.database.reference().child("conversation/receivers/list_receiver").observe(.value){ (snapshot) in
        Network.instance.getAllMessagesFor(channel: self.channel!, handler: { (returnedChannelMessage) in
            self.channelMessages =  returnedChannelMessage
            self.chatTableView.reloadData()
            if self.channelMessages.count > 0{
                self.chatTableView.scrollToRow(at: IndexPath(row: self.channelMessages.count - 1, section: 0), at: .none, animated: true)
            }
            
        })
            
        }
    }
    
    
    @IBAction func sendBtnWasPressed(_ sender: Any) {
        if messageTextField.text != "" {
            
            messageTextField.isEnabled =  false
            sendBtn.isEnabled = false
            Network.instance.uploadPost(withMessage: messageTextField.text!, forUID: Auth.auth().currentUser?.uid ?? "" , withUserKey: channel?.key ?? "") { (complete) in
                if complete{
                    self.messageTextField.text = ""
                    self.messageTextField.isEnabled = true
                    self.sendBtn.isEnabled = true
                    
                    
                }
            }
            
        }
        
        
    }
    

    @IBAction func backBtnWasPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
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
        
        return channelMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ChatMessagesCell else {return UITableViewCell()}
        
        let message =  channelMessages[indexPath.row]
        
        cell.senderMessage.text =  message.content
        
        
        return cell
    
//        Network.instance.getUsername(forUID: message.senderId) { (email) in
//
//
//        }
        
//        if let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ChatMessagesCell{
//
//            cell.senderMessage.text =  messages[indexPath.row]
//            cell.senderMessage.cornerRadius = 15
//
//
//            return cell
//        }
//        return ChatMessagesCell()
//
        
    }
    
   
    
    
    
    
}
