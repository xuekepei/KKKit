//
//  UIView+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/04/07.
//

import Foundation
import UIKit
import Combine

extension UIView {
    public func addKeyboardEventMonitor() {
        let animateDuration = 0.3
        _ = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification).sink { noti in
            let keyboardFrame = (noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            if let responder = UIResponder.firstResponder() {
                let rect = self.convert((responder.frame)!, from: responder.superview)
                let offset = -(rect.maxY - keyboardFrame.height)
                if offset > 0 {
                    return
                }
                UIView.animate(withDuration: animateDuration) {
                    self.transform = CGAffineTransform(translationX: 0, y: offset)
                }
            }
        }
        
        _ = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification).sink { noti in
            UIView.animate(withDuration: animateDuration) {
                self.transform = CGAffineTransform.identity
            }
        }
        
        self.addEndEditingGesture()
    }
    
    public func addEndEditingGesture() {
        let tapGesture = UITapGestureRecognizer()
        self.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(tapKeyBoardGestureAction(tap:)))
    }
    
    @objc func tapKeyBoardGestureAction(tap:UIGestureRecognizer) {
        self.endEditing(true)
    }
}

extension UIView {
    public func addBorder(_ edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let subview = UIView()
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.backgroundColor = color
        self.addSubview(subview)
        switch edge {
        case .top, .bottom:
            subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            subview.heightAnchor.constraint(equalToConstant: thickness).isActive = true
            if edge == .top {
                subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            } else {
                subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            }
        case .left, .right:
            subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
            subview.widthAnchor.constraint(equalToConstant: thickness).isActive = true
            if edge == .left {
                subview.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
            } else {
                subview.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
            }
        default:
            break
        }
    }
}

extension UIView {
    public func screenShot() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
