//
//  UIButton+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/04/07.
//

import Foundation
import UIKit

public extension UIButton {
    
    func fontSize(_ offset:CGFloat){
        self.titleLabel?.fontSize(offset)
    }
}

public extension UIButton {
    
    enum KKButtonImageEdgeInsetsStyle {
        case top, left, right, bottom
    }
    
    func imagePosition(at style: KKButtonImageEdgeInsetsStyle, space: CGFloat) {
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        
        labelWidth = self.titleLabel?.intrinsicContentSize.width
        labelHeight = self.titleLabel?.intrinsicContentSize.height
        
        //Init imageEdgeInsets and labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        //Get imageEdgeInsets and labelEdgeInsets value
        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight-space/2, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!, bottom: -imageHeight!-space/2, right: 0)
            break;
            
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2, bottom: 0, right: space)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2, bottom: 0, right: -space/2)
            break;
            
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight!-space/2, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight!-space/2, left: -imageWidth!, bottom: 0, right: 0)
            break;
            
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+space/2, bottom: 0, right: -labelWidth-space/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth!-space/2, bottom: 0, right: imageWidth!+space/2)
            break;
            
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}
