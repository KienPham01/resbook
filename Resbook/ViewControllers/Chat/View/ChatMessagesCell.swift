//
//  ChatMessagesCell.swift
//  Resbook
//
//  Created by Apple on 5/11/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit

class ChatMessagesCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var contentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateView(user:UserProfile) {
        
        self.profileImage.image = UIImage(named: user.avatar)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let contraint = [
            contentLbl.frame = CGRect(x: 0, y: 0, width: 100, height: 100),
            contentLbl.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0, alpha: 1),
        contentLbl.topAnchor.constraint(equalTo: topAnchor ),
        contentLbl.leadingAnchor.constraint(equalTo: leadingAnchor ),

        contentLbl.bottomAnchor.constraint(equalTo: bottomAnchor ),
        contentLbl.trailingAnchor.constraint(equalTo: trailingAnchor)] as [Any]
        
        NSLayoutConstraint.activate(contraint as! [NSLayoutConstraint])
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
