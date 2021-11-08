//
//  print.swift
//  KKKit
//
//  Created by xueke on 2021/04/16.
//

import Foundation

#if !DEBUG
public func print(items: Any..., separator: String = "", terminator: String = "") { }
#endif

public func dPrint(_ object: @autoclosure() -> Any?,
                   _ file: String = #file,
                   _ function: String = #function,
                   _ line: Int = #line) {
    #if DEBUG
    guard let value = object() else {
        return
    }
    var stringRepresentation: String?
    var statusString = "✅"

    if let value = value as? CustomDebugStringConvertible {
        stringRepresentation = value.debugDescription
    }
    else if let value = value as? CustomStringConvertible {
        stringRepresentation = value.description
    }
    if value is Error {
        statusString = "❌"
    }

    let gFormatter = DateFormatter()
    gFormatter.dateFormat = "HH:mm:ss:SSS"
    let timestamp = gFormatter.string(from: Date())
    let queue = Thread.isMainThread ? "UI" : "BG"
    let fileURL = NSURL(string: file)?.lastPathComponent ?? "Unknown file"

    if let string = stringRepresentation {
        print("\(statusString) \(timestamp) {\(queue)} \(fileURL) > \(function)[\(line)]: \(string)")
    } else {
        print("\(statusString) \(timestamp) {\(queue)} \(fileURL) > \(function)[\(line)]: \(value)")
    }
    #endif
}
