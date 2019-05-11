//
//  Extension+ViewController.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import UIKit
import PINRemoteImage

public enum StoryBoardName: String {
    case dashboard = "Dashboard"
    case authentication = "Main"
}

extension UIViewController{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    class func instantiateFromStoryboardHelper<T>(storyboardName: StoryBoardName, storyboardId: String) -> T {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardId) as! T
        return controller
    }
    
    class var className: String {
        return String(describing: self)
    }

}

extension UIImageView {
    public func loadImage(url: String, placeHolderImage: UIImage? = nil){
        self.pin_setImage(from: URL.init(string: url), placeholderImage: placeHolderImage)
    }
}
