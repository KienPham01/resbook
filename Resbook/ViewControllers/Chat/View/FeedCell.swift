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
    
    
    
//    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool) {
//        self.profileImage.image = image
//        self.userLbl.text = email
//        if isSelected {
//            self.statusLbl.text = "Not Found"
//        } else {
//        }
//    }
    
    func configureCell(userid:String,status:Int,avatar:String) {
        
        
        if status == 0{
            
            userLbl.text = "User not found "
            statusLbl.isHidden = true
            
            
        }
        else{
            
            userLbl.text = userid
            statusLbl.text = String(status)
            
            profileImage.image = UIImage(named: avatar)
            statusLbl.isHidden = false
            
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
