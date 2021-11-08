//
//  UIResponder+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/05/06.
//

import Foundation
import UIKit

private weak var currentFirstResponder: AnyObject?

public extension UIResponder {
    static func firstResponder() -> AnyObject? {
        currentFirstResponder = nil
        UIApplication.shared.sendAction(#selector(findFirstResponder(_:)), to: nil, from: nil, for: nil)
        return currentFirstResponder
    }
        
    @objc func findFirstResponder(_ sender: AnyObject) {
        currentFirstResponder = self
    }
}


