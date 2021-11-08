//
//  CIImage+Extension.swift
//  KKKit
//
//  Created by xueke on 2021/09/17.
//

import Foundation
import UIKit

extension CIImage {
    func pixelBuffer() -> CVPixelBuffer? {
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

extension CIImage {
    
    struct OverFrameInfo {
        let bgImage:CIImage
        let fullScreen:Bool
        var extent:CGRect?
    }
    
    func over(of frame:OverFrameInfo) -> CIImage? {
        guard let extent = frame.extent else {
            return nil
        }
        
        var inputImage:CIImage
        
        if frame.fullScreen {
            let aspectWidth  = extent.width/self.extent.width
            let aspectHeight = extent.height/self.extent.height
            let aspectRatio = min(aspectWidth, aspectHeight)
            
            let scaledPoint = CGPoint(x: (extent.width - self.extent.width * aspectRatio) / 2.0,
                                      y: (extent.height - self.extent.height * aspectRatio) / 2.0)
            
            inputImage = self.transformed(by: CGAffineTransform(scaleX: aspectRatio, y: aspectRatio)).transformed(by: CGAffineTransform(translationX: scaledPoint.x, y: scaledPoint.y))
            
        } else {
            let aspectWidth  = extent.width/self.extent.width
            inputImage = self.transformed(by: CGAffineTransform(scaleX: aspectWidth, y: aspectWidth)).transformed(by: CGAffineTransform(translationX: 0, y: extent.height * 0.45))
        }
        
        let bgAspectWidth  = extent.width/frame.bgImage.extent.width
        let bgAspectHeight = extent.height/frame.bgImage.extent.height
        let bgAspectRatio = max(bgAspectWidth, bgAspectHeight)
        
        let bgScaledPoint = CGPoint(x: (extent.width - frame.bgImage.extent.width * bgAspectRatio) / 2.0,
                                  y: (extent.height - frame.bgImage.extent.height * bgAspectRatio) / 2.0)
        
        let newBgImage = frame.bgImage.transformed(by: CGAffineTransform(scaleX: bgAspectRatio, y: bgAspectRatio)).transformed(by: CGAffineTransform(translationX: bgScaledPoint.x, y: bgScaledPoint.y))
        
        let compositedFilter = CIFilter(name: "CISourceOverCompositing")
        compositedFilter?.setValue(inputImage, forKey: kCIInputImageKey)
        compositedFilter?.setValue(newBgImage, forKey: kCIInputBackgroundImageKey)
        return compositedFilter?.outputImage
    }
    
}
