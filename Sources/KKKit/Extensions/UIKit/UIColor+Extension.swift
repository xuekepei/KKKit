//
//  UIColor+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/04/06.
//

import Foundation
import UIKit

extension UIColor {
//     MARK: - Convenience Intializers
    public convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    public convenience init(hexRGB:Int) {
        self.init(red:(hexRGB >> 16) & 0xff, green:(hexRGB >> 8) & 0xff, blue:hexRGB & 0xff)
    }
    
    public func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
            return UIGraphicsImageRenderer(size: size).image { rendererContext in
                self.setFill()
                rendererContext.fill(CGRect(origin: .zero, size: size))
            }
        }
    
    
//     MARK: - Primary colors

    public class func primaryBlackColor() -> UIColor {
        //  main color tone
        return UIColor(hexRGB: 0x191919)
    }
    
    public class func primaryWhiteColor() -> UIColor {
        //  main color tone
        return UIColor(hexRGB: 0xFFFFFF)
    }
    
    public class func primaryPinkColor() -> UIColor {
        //  main color tone
        return UIColor(hexRGB: 0xE05193)
    }
    
    public class func primaryRoseRedColor() -> UIColor {
        //  main color tone
        return UIColor(hexRGB: 0xE05193).withAlphaComponent(0.5)
    }
    
    public class func primaryGrayColor() -> UIColor {
        //  main color tone
        return UIColor(hexRGB: 0x3F3F3F)
    }
    
    public class func cgColors(hexRGB:Array<Int>, alpha:CGFloat = 1) -> Array<CGColor> {
        var colors = Array<CGColor>()
        for hex in hexRGB {
            let cgColor = UIColor(hexRGB: hex).withAlphaComponent(alpha).cgColor
            colors.append(cgColor)
        }
        
        return colors
    }
}
