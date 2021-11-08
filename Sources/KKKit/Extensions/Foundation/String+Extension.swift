//
//  String+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/04/06.
//

import Foundation

extension String {
    
    public var localized: String! {
//        Localization of string
        let localizedString = NSLocalizedString(self, comment: "")
        return localizedString
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
    public var isURL: Bool {
        let urlRegEx = "^((https|http|ftp|rtsp|mms)?:\\/\\/)[^\\s]+"
        
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        return urlTest.evaluate(with: self)
    }
}
