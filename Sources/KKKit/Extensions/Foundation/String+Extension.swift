//
//  String+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/04/06.
//

import Foundation
import UIKit

extension String {
    
    public var localized: String {
//     Localization of string
        return NSLocalizedString(self, comment: "") 
    }
    
    public func localized(args : CVarArg...) -> String {
        return withVaList(args, { (f:CVaListPointer) -> String in
            (NSString.init(format:NSLocalizedString(self, comment:""), arguments: f) as String)
         })
    }
    
    public var url : URL? {
        return URL(string: self)
    }
    
    public var lastPathComponent : String {
        return String(self.split(separator: "/").last ?? "")
    }
    
    public func convertToDictionary() -> [String:AnyObject]? {
        if let data = self.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                dPrint("Something went wrong")
            }
        }
        return nil
    }
    
    public func convertToArray() -> [[String:AnyObject]]? {
        if let data = self.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String:AnyObject]]
                return json
            } catch {
                dPrint("Something went wrong")
            }
        }
        return nil
    }
    
    public func jwtDecode()->[String: Any]{
        let segments = components(separatedBy: ".")
        var base64String = segments[1]
        // base64 decode
        let requiredLength = (4 * ceil((Float)(base64String.count)/4.0))
        let nbrPaddings = Int(requiredLength) -  base64String.count
        if nbrPaddings > 0 {
            let pading = "".padding(toLength: nbrPaddings,withPad: "=",startingAt: 0)
            base64String = base64String + pading
        }
        base64String = base64String.replacingOccurrences(of: "-",with: "+")
        base64String = base64String.replacingOccurrences(of: "_",with: "/")
        let decodeData = Data(base64Encoded: base64String,options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        let decodeString = String.init(data: decodeData!,encoding: String.Encoding.utf8)
        // To dic
        let jsonDict:[String : Any]? = try? (JSONSerialization.jsonObject(with:(decodeString?.data(using: String.Encoding.utf8))!,options: JSONSerialization.ReadingOptions.mutableContainers) as![String : Any])
        // Return dic
        return jsonDict ?? [:]
    }
}

extension String {
    // MARK: - Regular
    public func evaluate(_ regEx: String) -> Bool {
        let urlTest = NSPredicate(format:"SELF MATCHES %@", regEx)
        return urlTest.evaluate(with: self)
    }
    
    public var isEmail: Bool {
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return self.evaluate(regEx)
    }
    
    public var isPhone: Bool {
        let regEx = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
        return self.evaluate(regEx)
    }
    
    public var isURL: Bool {
        let urlRegEx = "^((https|http|ftp|rtsp|mms)?:\\/\\/)[^\\s]+"
        
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        return urlTest.evaluate(with: self)
    }
}

extension String {
    
    public func image(with attributes : [NSAttributedString.Key:Any] = [.foregroundColor:UIColor.black,.font:UIFont.systemFont(ofSize: 10.0)]) -> UIImage {
        let size = (self as NSString).size(withAttributes: attributes)
        return UIGraphicsImageRenderer(size: size).image { _ in
            (self as NSString).draw(in: CGRect(origin: .zero, size: size), withAttributes: attributes)
        }
    }
}

extension String {
    /**
     生成随机字符串,
     
     - parameter length: 生成的字符串的长度
     
     - returns: 随机生成的字符串
     */
    public static func random(of length: Int = 6) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
            
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

