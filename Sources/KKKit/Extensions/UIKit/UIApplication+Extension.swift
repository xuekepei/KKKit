//
//  UIApplication+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/04/09.
//

import UIKit

public extension UIApplication {
    
    func activityWindow() -> UIWindow? {
        // Find the top-most View Controller
        let keyWindow = UIApplication.shared.windows
                .filter({$0.isKeyWindow}).first
        return keyWindow
    }
    
    func activityViewController() -> UIViewController? {
        // Find the top-most View Controller
        let keyWindow = self.activityWindow()
        let base: UIViewController? = keyWindow?.rootViewController
        return getTopMostViewController(base)
    }
    
    private func getTopMostViewController(_ base:UIViewController?) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopMostViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return getTopMostViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return getTopMostViewController(presented)
        }
        return base
    }
}
