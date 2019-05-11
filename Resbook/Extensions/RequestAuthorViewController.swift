//
//  RequestAuthorViewController.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/4/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit

class RequestAuthorViewController: UIViewController {
    
    @IBOutlet weak var allowLabel: UILabel!
    @IBOutlet weak var seletedLabel: UILabel!
    @IBOutlet weak var cameraImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var type = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        switch type {
        case 0:
            self.titleLabel.text = "Resshare chưa có quyền truy cập máy ảnh, ứng dụng cần quyền này để cập nhật ảnh đại diện của bạn, để cấp quyền thực hiện những bước sau"
            self.cameraImage.image = UIImage.init(named: "camera")
            self.seletedLabel.text = "3. Ấn vào camera"
            self.allowLabel.text = "4. Cho phép ứng dụng truy cập vào camera"
        default:
            self.cameraImage.image = UIImage.init(named: "Gallery")
            self.seletedLabel.text = "3. Ấn vào thư viện"
            self.titleLabel.text = "Resshare chưa có quyền truy cập bộ sưu tập ảnh, ứng dụng cần quyền này để cập nhật ảnh đại diện của bạn, để cấp quyền thực hiện những bước sau"
            self.allowLabel.text = "4. Cho phép ứng dụng truy cập vào thư viện"
        }
    }
    
    static func newInstance() -> RequestAuthorViewController {
        return RequestAuthorViewController.instantiateFromStoryboardHelper(storyboardName: .dashboard, storyboardId: RequestAuthorViewController.className)
    }
    
    @IBAction func tapDismis(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func tapSetting(_ sender: Any) {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

