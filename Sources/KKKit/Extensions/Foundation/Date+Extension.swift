//
//  Date+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/04/12.
//

import Foundation

extension Date {
    
    public func localString(formatter :String = "YYYY\("year".localized!)MM\("month".localized!)dd\("day".localized!)(EEE) HH:mm", locale: Locale = Locale(identifier: "ja_JP") ) -> String {
        // Localize date as a string
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .japanese)
        dateFormatter.locale = locale
        dateFormatter.dateFormat = formatter
        
        return dateFormatter.string(from: self)
    }
    
    /// Get time difference
    /// - Parameter date: Date
    /// - Returns: DateComponents
    public func components(from date:Date = Date(),unit : Set<Calendar.Component> = [.day , .hour , .minute , .second]) -> DateComponents {
        
        let calendar = Calendar(identifier: .japanese)
        let components = calendar.dateComponents(unit, from: date,to: self)
        return components
    }
    
    public func startOfMonth() -> Date {
        let calendar = NSCalendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        let startOfMonth = calendar.date(from: components)!
        return startOfMonth
    }
    
    public func endOfMonth() -> Date {
        let calendar = NSCalendar.current
        var components = DateComponents()
        components.month = 1
        components.second = -1
        let endOfMonth = calendar.date(byAdding: components, to: self.startOfMonth())!
        return endOfMonth
    }

}

extension Date {
    public init(_ time:String, _ dateFormatter:String?=nil) {
        let formatter = DateFormatter.serverSyncDateFormatter
        if dateFormatter != nil {
            formatter.dateFormat = dateFormatter
        }
        self = formatter.date(from: time)!
        
    }
}

extension Date {
    public func second(_ fromDate:Date=Date()) -> Int {
        return lroundf(Float(self.timeIntervalSince(fromDate)))
    }
}
