//
//  CIImage+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/09/17.
//

import Foundation
import UIKit

extension CIImage {
    public func pixelBuffer() -> CVPixelBuffer? {
        var pixelBuffer: CVPixelBuffer?
        let attrs = [kCVPixelBufferCGImageCompatibilityKey as String :true ,
                     kCVPixelBufferCGBitmapContextCompatibilityKey as String :true,
                     kCVPixelBufferIOSurfacePropertiesKey as String :[:]] as [String:Any]
        let width:Int = Int(self.extent.width)
        let height:Int = Int(self.extent.height)
        let status = CVPixelBufferCreate(kCFAllocatorDefault,
                            width,
                            height,
                            kCVPixelFormatType_420YpCbCr8BiPlanarFullRange,
                            attrs as CFDictionary,
                            &pixelBuffer)
        
        guard (status == kCVReturnSuccess) else {
          return nil
        }
        let context = CIContext(options: nil)
        context.render(self, to: pixelBuffer!)
        return pixelBuffer
    }
}
