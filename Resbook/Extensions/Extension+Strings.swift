//
//  Extension+Strings.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    private func showPopupAlert(message: String) {
        let alert = UIAlertController.Style.alert.controller(message: message, actions: ["OK".alertAction(style: .cancel, handler: nil)])
        Supports.getTopController().present(alert, animated: true, completion: nil)
        
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluate(with: self)
        
        if !result {
            showPopupAlert(message: "The email is invalid")
            return false
        } else {
            return true
        }
    }
    
    func isValidPassword() -> Bool {
        let result = self.count >= 6
        
        if !result {
            showPopupAlert(message: "The passord is invalid")
            return false
        } else {
            return true
        }
    }
    
    func isValidPhone() -> Bool {
        let phonenumberRegex = "^(\\+[0-9]{2})[0-9]{6,14}|[0-9]{6,14}$"
        let phonenumber = NSPredicate(format:"SELF MATCHES %@", phonenumberRegex)
        let result = phonenumber.evaluate(with: self)
        
        if !result {
            showPopupAlert(message: "The phone number is invalid")
            return false
        } else {
            return true
        }
    }
    
    func toDate(dateFormat:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone.local
        var dateObj = dateFormatter.date(from: self)
        if dateObj == nil {
            dateFormatter.dateFormat = DateFormat.YYYYMMDD.rawValue
            dateObj = dateFormatter.date(from: self)
        }
        return dateObj
    }
    func toDate2(dateFormat:String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = NSTimeZone.local
        var dateObj = dateFormatter.date(from: self)
        if dateObj == nil {
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateObj = dateFormatter.date(from: self)
        }
        return dateObj
    }
    
}
