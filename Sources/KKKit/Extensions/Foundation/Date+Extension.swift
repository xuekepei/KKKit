//
//  Date+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/04/12.
//

import Foundation

extension Date {
    
    public func localString(formatter :String = "YYYY\("year".localized)MM\("month".localized)dd\("day".localized)(EEE) HH:mm", locale: Locale = Locale(identifier: "ja_JP") ) -> String {
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

extension Date {
    public func localityString(unit : Array<Calendar.Component> = [.year, .month], separate: Bool = true) -> String {
        let unitDic: Dictionary<Calendar.Component, Array<String>> = [.year: ["YYYY","year"],
                                                                      .month: ["MM","month"],
                                                                      .day: ["dd","day"],
                                                                      .hour: ["HH","hour"],
                                                                      .minute: ["mm","minute"],
                                                                      .second: ["ss","second"]]
        var formatter = ""
        unit.forEach { u in
            let unitList = unitDic[u]
            formatter.append(unitList?.first ?? "")
            if separate {
                formatter.append(unitList?.last?.localized ?? "")
            }
        }
        
        return localString(formatter: formatter, locale: Locale(identifier: "zh_Hans_CN"))
    }
    
    func localityWeekday() -> String {
        let calendar:Calendar = Calendar(identifier: .gregorian)
        var comps:DateComponents = DateComponents()
        comps = calendar.dateComponents([.weekday], from: self)
     
        let weekDay = comps.weekday! - 1
        
        //星期
        let array = ["sunday","monday","tuesday","wednesday","thursday","friday","saturday"]
        let week = array[weekDay]
        return week.localized
    
    }
}

public extension Date {
    init(year:Int = 2022, month: Int = 1, day: Int = 1) {
        let calendar = Calendar.current
        let comps = DateComponents(calendar: calendar,
                                   timeZone: TimeZone(identifier: "zh_Hans_CN"),
                                   year: year,
                                   month: month,
                                   day: day)
        self = comps.date!
    }
}

public extension Date {
    
    func add(day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: self) ?? self
    }
    
    func add(month: Int) -> Date {
        return Calendar.current.date(byAdding: .month, value: month, to: self) ?? self
    }
    
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    func endOfDay() -> Date {
        return Calendar.current.date(byAdding: .second, value: -1, to: startOfDay().add(day: 1)) ?? self
    }
}

public extension Date {
    
    func isBetween(_ start: Date, and end: Date) -> Bool {
        return start.compare(self) == self.compare(end)
    }
    
    func inSameDay(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, inSameDayAs: date)
    }
    
    func inSameMonth(_ date: Date) -> Bool {
        return Calendar.current.isDate(self, equalTo: date, toGranularity: .month)
    }
}

public extension Date {
    func daysInMonth() -> Int {
        return Calendar.current.range(of: .day, in: .month, for: self)?.count ?? 0
    }
    
    func weeksInMonth() -> Int {
        return Calendar.current.range(of: .weekOfMonth, in: .month, for: self)?.count ?? 0
    }
    
    func year() -> Int {
        return Calendar.current.dateComponents([.year], from: self).year ?? 0
    }
        
    func month() -> Int? {
        return Calendar.current.dateComponents([.month], from: self).month ?? 0
    }
    
    func day() -> Int? {
        return Calendar.current.dateComponents([.day], from: self).day ?? 0
    }
    
    func weekday() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday ?? 0
    }
}
