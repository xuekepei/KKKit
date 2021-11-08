//
//  UILabel+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/04/09.
//

import Foundation
import UIKit

extension UILabel {
    
    public func fontSize(_ offset:CGFloat) {
        // Set the offset of the font size
        let font = self.font.withSize(UIFont.labelFontSize + offset)
        self.font = font
    }
}
