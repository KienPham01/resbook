//
//  Extensions.swift
//  Resbook
//
//  Created by Thuy Truong Quang on 5/3/19.
//  Copyright © 2019 Thuy Truong Quang. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UIDevice
extension UIDevice {
    
    /// Check device iphone or ipad
    var isIphone: Bool {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return true
        // It's an iPhone
        default:
            return false
        }
    }
    enum ScreenType: String {
        case iPhone
        case iPhonePlus
        case unknown
    }
    var screenType: ScreenType {
        guard isIphone else { return .unknown }
        switch UIScreen.main.nativeBounds.height {
        case 1334:
            return .iPhone
        case 2208:
            return .iPhonePlus
        default:
            return .unknown
        }
    }
}

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

enum DateFormat: String {
    case HHmmDDMMYYYY = "HH:mm dd/MM/yyyy"
    case DDMMYYYY = "dd/MM/yyyy"
    case YYYYMMDD = "yyyy-MM-dd"
    case HH_mm_DD_MM_YYYY = "HH_mm_dd_MM_yyyy"
    case ddMMyyyyHHmm = "dd/MM/yyyy HH:mm"
    case HHmm = "HH:mm"
    case hhmma = "hh:mm a"
    case ddhhmma = "dd hh:mm a"
    case hhmmass = "hh:mm:ss a"
    case HHmmss = "HH:mm:ss"
    case yyyyMMddHHmmssSSSz = "yyyy-MM-dd'T'HH:mm:ss.SSSz"
    case yyyyMMddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case yyyyMMddHHmmssSSS = "yyyy-MM-dd HH:mm:ss.SSS"
    case MMddyyyyHHmm = "MM-dd-yyyy HH:mm"
    case MMMddyyyyHHmm = "MMM-dd-yyyy HH:mm"
    case MMMddyyyyhhmma = "MMM dd yyyy hh:mm a"
    case MMMddyyyyhhmmssa = "MMM dd, yyyy hh:mm:ss a"
    case MMMddyyyy = "MMM dd, yyyy"
    case MMMyyyy = "MMM yyyy"
    case yyyyMMddHHmmssSSS_Z = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case yyyyMMddTHHmma = "yyyy-MM-dd hh:mm a"
    case ddMMyyyyTHHmmssa = "dd-MM-yyyy hh:mm:ss a"
    case MMM_dd = "MMM-dd"
    case dd = "dd"
    case E = "E"
    case EEEE = "EEEE"
    case yyyyMMddhhmm = "yyyy-HH-dd hh:mm"
    case yyyyMMddHHmmssZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    case ddMMMyyyyhhmma = "dd MMM yyyy hh:mm a"
    case ddMMMyyyyhhmmssa = "dd MMM yyyy hh:mm:ss a"
}

extension Date {
    func toString(dateFormat: DateFormat? = .HHmmDDMMYYYY) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat?.rawValue
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        return dateFormatter.string(from: self)
    }
    
    func toLocalTimeString(dateFormat: DateFormat = .HHmmDDMMYYYY) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat.rawValue
        dateFormatter.timeZone = NSTimeZone.local
        return dateFormatter.string(from: self)
    }
    
    func localTimeFormat(dateFormat: DateFormat? = .HHmmDDMMYYYY) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = dateFormat?.rawValue
        dateFormatter.timeZone = NSTimeZone.local
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: self)
        
    }
    
    func setTime(hour: Int, min: Int,sec: Int, nanosec: Int = 000 , timeZoneAbbrev: String = "UTC") -> Date? {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone(abbreviation: timeZoneAbbrev)
        component.hour = hour
        component.minute = min
        component.second = sec
        component.nanosecond = nanosec
        return cal.date(from: component)
    }
    
    func addDay(day: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone(abbreviation: "UTC")
        component.day = component.day! + day
        return cal.date(from: component)!
    }
    
    func subDay(day: Int) -> Date {
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone(abbreviation: "UTC")
        component.day = component.day! - day
        return cal.date(from: component)!
    }
    
    func addSecond(seconds: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone.current
        component.second = component.second! + seconds
        return cal.date(from: component)!
    }
    
    func addDayLocal(day: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone.current
        component.day = component.day! + day
        return cal.date(from: component)!
    }
    func setDate(date: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.day = date
        return cal.date(from: component)!
    }
    func setDate(date: Int, month: Int, year: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone(abbreviation: "UTC")
        component.day = date
        component.month = month
        component.year = year
        return cal.date(from: component)!
    }
    func setDateLocal(date: Int, month: Int, year: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = NSTimeZone.local
        component.day = date
        component.month = month
        component.year = year
        return cal.date(from: component)!
    }
    
    func getMinute() -> Int {
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        let component = cal.dateComponents(x, from: self)
        return component.minute!
    }
    
    func getHour() -> Int {
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        let component = cal.dateComponents(x, from: self)
        return component.hour!
    }
    
    func getDay() -> Int {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        let component = cal.dateComponents(x, from: self)
        return component.day!
    }
    func getMonth() -> Int {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        let component = cal.dateComponents(x, from: self)
        return component.month!
    }
    func getYear() -> Int {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        let component = cal.dateComponents(x, from: self)
        return component.year!
    }
    func setDateUTC() -> Date? {
        
        let x: Set<Calendar.Component> = [.year, .month, . day, . hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.date(from: component)
    }
    func setDateUTCDefault() -> Date? {
        
        let x: Set<Calendar.Component> = [.year, .month, . day, . hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        component.hour = component.hour!
        return cal.date(from: component)
    }
    func toInt() -> Int64 {
        
        let interval = self.timeIntervalSince1970
        return Int64(interval * 1000)
        
    }
    func startOfWeek(weekday: Int?) -> Date {
        var cal = Calendar.current
        var component = cal.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        component.timeZone = TimeZone.current
        component.to12am()
        cal.firstWeekday = weekday ?? 1
        return cal.date(from: component)!
    }
    func getDayInWeek(day: Int?) -> Date {
        let cal = Calendar.current
        var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: self)
        comps.timeZone = TimeZone.current
        comps.weekday = day ?? 1 // Monday
        let mondayInWeek = cal.date(from: comps)!
        return mondayInWeek
    }
    
    func endOfWeek(weekday: Int) -> Date {
        let cal = Calendar.current
        var component = DateComponents()
        component.weekOfYear = 1
        component.day = -1
        return cal.date(byAdding: component, to: startOfWeek(weekday: weekday))!
    }
    func setTime(hour: Int, min: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        var dateComponents = DateComponents()
        dateComponents.year = component.year
        dateComponents.month = component.month
        dateComponents.day = component.day
        dateComponents.timeZone = TimeZone(secondsFromGMT: 7)
        dateComponents.hour = hour
        dateComponents.minute = min
        let someDateTime = cal.date(from: dateComponents)
        return someDateTime!
    }
    
    func setLocalTime(hour: Int, min: Int) -> Date {
        
        let  x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var component = cal.dateComponents(x, from: self)
        var dateComponents = DateComponents()
        dateComponents.year = component.year
        dateComponents.month = component.month
        dateComponents.day = component.day
        dateComponents.timeZone = NSTimeZone.local
        dateComponents.hour = hour
        dateComponents.minute = min
        let someDateTime = cal.date(from: dateComponents)
        return someDateTime!
    }
    
    func getWeekDay() -> Int {
        
        let mCalendar = Calendar.current
        let weekDay = mCalendar.component(.weekday, from: self)
        return weekDay
    }
    
    func getWeekOfYear() -> Int {
        
        let mCalendar = Calendar.current
        let weekOfYear = mCalendar.component(.weekOfYear, from: self)
        return weekOfYear
    }
    
    func isToday() -> Bool {
        
        return Calendar.current.isDateInToday(self)
    }
    
    func parseDateTime(dateString: String) -> (date: String, time: String) {
        // Check available
        if dateString == "" {
            return ("", "")
        }
        // Convert from String to Date
        let date = dateString.toDate(dateFormat: DateFormat.yyyyMMddHHmmssZ.rawValue)
        // Convert from Date to String
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "MMM dd yyyy-hh:mm a"
        let datePrintString = dateFormatterOutput.string(from: date!)
        // Return date by custom format
        let dateStringArr = datePrintString.components(separatedBy: "-")
        let dateReturn: (date: String, time: String) = (date: dateStringArr[0], time: dateStringArr[1])
        return dateReturn
    }
    
    func generateDatesArrayBetweenTwoDates(startDate: Date , endDate:Date) ->[Date] {
        var datesArray: [Date] =  [Date]()
        var startDate = startDate
        let calendar = Calendar.current
        
        while startDate <= endDate {
            startDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
            datesArray.append(startDate)
        }
        return datesArray
    }
    
    
    
}

internal extension DateComponents {
    mutating func to12am() {
        self.hour = 0
        self.minute = 0
        self.second = 0
    }
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension Array where Element : Equatable {
    
    public mutating func mergeElements<C : Collection>(newElements: C) where C.Iterator.Element == Element{
        let filteredList = newElements.filter({!self.contains($0)})
        self.append(contentsOf: filteredList)
    }
    
}

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}

enum VerticalLocation: String {
    case bottom
    case top
}

extension UIView {
    func addShadow(location: VerticalLocation, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0, height: CGFloat = 10) {
        switch location {
        case .bottom:
            addShadow(offset: CGSize(width: 0, height: height), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: -height), color: color, opacity: opacity, radius: radius)
        }
    }
    
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
}

extension Float{
    
    func cToF() -> Float {
        
        return self * (9/5) + 32
    }
}

extension Double{
    
    func cToF() -> Double {
        
        return self * (9/5) + 32
    }
}
