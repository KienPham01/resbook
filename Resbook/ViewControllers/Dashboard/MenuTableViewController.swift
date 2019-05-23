
//
//  MenuTableViewController.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    let userProfile = DataServices.sharedInstance.userProfile
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        }
    }
    @IBOutlet weak var currentNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func configUI() {
        
        imageView.loadImage(url: userProfile?.avatar ?? "", placeHolderImage: #imageLiteral(resourceName: "user"))
        currentNameLabel.text = userProfile?.user_name
        emailLabel.text = userProfile?.mail_address
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 3:
            Network.instance.signOut()
        default:
            break
        }
    }
}
