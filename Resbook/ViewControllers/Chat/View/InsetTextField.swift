//
//  InsetTextField.swift
//  Resbook
//
//  Created by Apple on 5/15/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import UIKit
class InsetTextField: UITextField {
    private var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    
    override func awakeFromNib() {
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
        
        self.attributedPlaceholder = placeholder
        super.awakeFromNib()
    }
    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
////        return UIEdgeInsetsInsetRect(bounds, padding)
//        return UIEdgeInsets
//    }
//
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, padding)
//    }
//
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return UIEdgeInsetsInsetRect(bounds, padding)
//    }
    
}
