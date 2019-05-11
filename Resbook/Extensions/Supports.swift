//
//  Supports.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/6/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import UIKit

class Supports: NSObject {
    class func getTopController(controller: UIViewController? = AppDelegate.sharedInstance.window?.rootViewController ?? UIViewController()) -> UIViewController {
        if let navigationController = controller as? UINavigationController {
            return getTopController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return getTopController(controller: selected)
            } else if let seledted = tabController.viewControllers?.first {
                return getTopController(controller: seledted)
            }
        }
        if let presented = controller?.presentedViewController {
            return getTopController(controller: presented)
        }
        return controller ?? UIViewController()
    }
}
