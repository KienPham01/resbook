//
//  FeedCell.swift
//  Resbook
//
//  Created by Apple on 5/11/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var userLbl: UILabel!
    
    @IBOutlet weak var  statusLbl: UILabel!
    var showing =  false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//    
    func configureCell(feed:FeedMessage)  {
        
        self.userLbl.text = feed._user_id
        
        
//        self.userLbl.text = feed.user_id
//        self.statusLbl.text = String(feed.status)

        if feed.status == 0{
            userLbl.text = "user not found"
            print("Not Found")

        }else{
            
            print("here your value")


        }
        


        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected{
            if showing == false{
                
                profileImage.isHidden = false
                showing = true
            }else{
                profileImage.isHidden = true
                showing = false
            }
        }

    }

}
