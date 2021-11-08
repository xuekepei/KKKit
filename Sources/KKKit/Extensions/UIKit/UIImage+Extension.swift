//
//  UIImage+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/04/15.
//

import Foundation
import UIKit

extension UIImage {
    public convenience init?(base64:String) {
        // base64 encode string convert to UIImage
        guard let imageStr = base64.components(separatedBy: ",").last else {
            return nil
        }
        guard let dataDecoded = Data(base64Encoded: imageStr , options: .ignoreUnknownCharacters) else {
            return nil
        }
        self.init(data: dataDecoded)
    }
}

extension UIImage {
    
    public func jpgBase64() -> String {
        let imageData = self.jpegData(compressionQuality: 1.0)
        return imageData?.jpgBase64() ?? ""
    }
    
    public func pngBase64() -> String {
        let imageData = self.pngData()
        return imageData?.pngBase64() ?? ""
    }
}

extension UIImage {
    
    public func jpeg(_ quality:CGFloat = 1.0, _ orientation:UIImage.Orientation = .up) -> Data? {
        guard let ciImage = self.ciImage else {
            return nil
        }
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        let mirrorImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: orientation)
        return mirrorImage.jpegData(compressionQuality: quality)
    }
    
    public func png(_ orientation:UIImage.Orientation = .up) -> Data? {
        guard let ciImage = self.ciImage else {
            return nil
        }
        let context = CIContext(options: nil)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        let mirrorImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: orientation)
        return mirrorImage.pngData()
    }
}


