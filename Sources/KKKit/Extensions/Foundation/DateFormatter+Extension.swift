//
//  DateFormatter+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/04/12.
//

import Foundation

public extension DateFormatter {
    static let iso8601Full: DateFormatter = {
        //Full time format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter
    }()
    
    static let serverSyncDateFormatter: DateFormatter = {
        //Full time format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter
    }()
    
    static let serverFormatter: DateFormatter = {
        //Server time format
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        return formatter
    }()
}
