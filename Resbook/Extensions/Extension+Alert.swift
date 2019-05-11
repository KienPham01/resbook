//
//  Extension+Alert.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import SVProgressHUD

typealias AlertActionHandler = ((UIAlertAction) -> Void)

extension UIAlertController.Style {
    
    func controller(title: String? = nil, message: String?, actions: [UIAlertAction]) -> UIAlertController {
        SVProgressHUD.dismiss()
        let _controller = UIAlertController(
            title: title,
            message: message,
            preferredStyle: self
        )
        actions.forEach { _controller.addAction($0) }
        return _controller
    }
}

extension String {
    
    func alertAction(style: UIAlertAction.Style = .default, handler: AlertActionHandler? = nil) -> UIAlertAction {
        return UIAlertAction(title: self, style: style, handler: handler)
    }
}
