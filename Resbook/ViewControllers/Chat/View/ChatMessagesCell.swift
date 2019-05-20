//
//  ChatMessagesCell.swift
//  Resbook
//
//  Created by Apple on 5/11/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit

class ChatMessagesCell: UITableViewCell {
    
    

    @IBOutlet weak var senderMessage: UILabel!
    
    @IBOutlet weak var  receiveMessage:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        senderMessage.cornerRadius = 15
        
        
        

        // Initialization code
    }
    
    

   
    
   
   
    
  
    
}
