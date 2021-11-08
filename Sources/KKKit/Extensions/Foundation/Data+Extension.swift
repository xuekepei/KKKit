//
//  Data+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/10/08.
//

import Foundation

extension Data {
    public func jpgBase64() -> String {
        let strBase64:String = self.base64EncodedString()
        return "data:image/jpg;base64,\(strBase64)"
    }
    
    public func pngBase64() -> String {
        let strBase64:String = self.base64EncodedString()
        return "data:image/png;base64,\(strBase64)"
    }
}
